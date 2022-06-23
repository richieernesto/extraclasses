import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../helpers/auth_errors.dart';
class AuthScreen extends StatefulWidget {
  //const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
   bool _isLoading = false;
   bool _isLogin = true;
  String _username = "";
  String _password = "";
  String _fullName = "";
  final _auth = FirebaseAuth.instance;
  var errorMessage;
  final errMsg = new AuthErrors();

  void _displayErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text (message, textAlign: TextAlign.center,)

        ,)
        ,);
  }
  
  
  void _showErrorDialog(String message) {
    Fluttertoast.showToast(msg: message);
    HapticFeedback.lightImpact();
  }

  void _trySubmit()async{
    UserCredential authResult;
    try{
      setState(() {
        _isLoading = true;
      });
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    
    if(isValid){
      _formKey.currentState!.save();
      if(_isLogin){
        authResult = await _auth.signInWithEmailAndPassword(email: _username, password: _password);
      }
      else{
        authResult = await _auth.createUserWithEmailAndPassword(email: _username, password: _password);
        await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
          'username': _username, 'fullname': _fullName
        });
      }

    }
    
    } on FirebaseAuthException catch(error){
      if (error.message != null){
       errorMessage = errMsg.detectedErrors[error.message];
        //  errorMessage = "Sorry Something went Wrong!";
         print(error.message);
         _showErrorDialog(errorMessage);
       }
      
      // else {
      //   print(errorMessage);
      // _showErrorDialog("Authentication Failed");}
      errorMessage = "";
    }
   catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'lib/assets/images/bgimage.jpg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 7, sigmaX: 7),
                            child: Form(
                              key: _formKey,
                              child: SizedBox(
                                width: size.width * .8,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        _isLogin? 'SIGN IN' : "REGISTER",
                                        
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          
                                        ),
                                      ),
                                    ),

                                    if (!_isLogin) SizedBox(
                                      height: size.width / 8,
                                      child: Container(
                                        height: size.width / 8,
                                        width: size.width / 1.25,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            right: size.width / 30),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.1),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: TextFormField(
                                          onSaved: (value){
                                            _fullName = value!;
                                          },
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(.9),
                                          ),
                                          decoration: InputDecoration(
                                            //contentPadding: EdgeInsets.only(top:5),
                                            prefixIcon: Icon(
                                              (Icons.person),
                                              color: Colors.white.withOpacity(.8),
                                            ),
                                            border: InputBorder.none,
                                            hintMaxLines: 1,
                                            hintText: "Full Name",
                                            hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withOpacity(.5),
                                            ),
                                          ),
                                          validator: (value){
                                            if (value == null){
                                              //Fluttertoast.showToast(msg: "Name not entered");
                                              //return "Name Not entered";
                                              _displayErrorDialog("Name not entered");
                                            }
                                            if(value != null && value.length <4 ){
                                              Fluttertoast.showToast(msg: "Name not entered");
                                              _displayErrorDialog("Name must not be less than 4");
                                              //return "Invalid Name";
                                            }
                                          },
                                          
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: size.width / 30
                                          
                                          ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        onSaved: (value){
                                          _username = value!;
                                        },
                                        validator: (value){
                                          if (value != null && !value.contains("@") && value.length < 7){
                                            //Fluttertoast.showToast(msg: "Invalid Email");
                                            _displayErrorDialog("Invalid Email");
                                            //return "Invalid email";
                                          }
                                          if (value == null){
                                            _displayErrorDialog("Enter Email");
                                            //Fluttertoast.showToast(msg: "Enter Email");
                                            //return "No Email Entered";
                                          }
                                        },
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                        //obscureText: isPassword,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            (Icons.email),
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: size.width / 30),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        onSaved: (value){
                                          _password = value!;
                                        },
                                        validator: (value){
                                          if(value==null){
                                            _displayErrorDialog("No Password Entered");
                                            //Fluttertoast.showToast(msg: "No Password entered");
                                            //return "No password entered";
                                          }
                                          if (value !=null && value.length < 6){
                                            _displayErrorDialog("Password must be atleast 6 characters");
                                            //Fluttertoast.showToast(msg: "Password must be atleast 7 characters");
                                            //return "Password must be at least 7 characters";
                                          }
                                        },
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            (Icons.password),
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (!_isLogin)
                                    Container(
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          right: size.width / 30),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextFormField(

                                        validator: (value){
                                          if (value == null){
                                            _displayErrorDialog("Passwords dont match");
                                            //Fluttertoast.showToast(m
                                            //msg: "Passwords dont Match");
                                            //return "Enter Password again!";
                                          }
                                          if (value != _passwordController.text){
                                            _displayErrorDialog("Passwords dont match");
                                            //Fluttertoast.showToast(msg: "Passwords dont Match");
                                            //return "Paswords dont Match";
                                          }
                                          
                                        },
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(.9),
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            (Icons.password),
                                            color: Colors.white.withOpacity(.8),
                                          ),
                                          border: InputBorder.none,
                                          hintMaxLines: 1,
                                          hintText: "Confirm Password",
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        if (_isLogin) GestureDetector(
                                          child: Text(
                                            'Forgot password!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                            ),
                                           
                                          ),
                                          onTap: (){},
                                        ),
                                           
                                            GestureDetector(
                                          child: 
                                            Text(
                                            _isLogin? "Sign Up Instead" : "Sign In",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18
                                            ),
                                          ),
                                          onTap: (){
                                            setState(() {
                                              _isLogin = !_isLogin;
                                            });
                                          }
                                        )
                                      ],
                                    ),
                                    SizedBox(),
                                    if (_isLoading)
                                       CircularProgressIndicator()
                                   else
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: _trySubmit,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          bottom: size.width * .05,
                                        ),
                                        height: size.width / 8,
                                        width: size.width / 2.5,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.1),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          _isLogin?  'Sign In' : "Sign Up",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
