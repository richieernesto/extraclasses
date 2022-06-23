import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              width: size.width/1.05,
              decoration: BoxDecoration(
                color: Color.fromRGBO(239, 239, 238, 1),
                borderRadius: BorderRadius.circular(5),
                ),
                child:Row(
                  children: [
                    Container(
                      height: size.height/7,
                      child: CircleAvatar(
                        radius: size.height/9 ,
                        child: Text(
                          "TU"
                        ),
                      )
                    ), 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("User Name"),
                        Text("test@test.com"),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          child: Text("Edit Profile", style: TextStyle(
                            color: Colors.black 
                          ),),
                          onPressed: (){},
                          style: ButtonStyle(
                            backgroundColor:  MaterialStateProperty.all<Color>(Colors.white),
                            shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Theme.of(context).primaryColor)
                              )
                              )
                            )
                          ),
                        
                      ]
                    )
                  ],
                )
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                color: Color.fromRGBO(239, 239, 238, 1),
                borderRadius: BorderRadius.circular(5),
                ),
                height: size.height/4,
                width: size.width/1.05,
                child:Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),

                    ),
                    InkWell(
                      child:Text(
                        "Some Text"
                      )
                    ),
                    Divider(),
                    InkWell(
                      child: Text("Some Text")),
                    Divider(),
                    InkWell(
                      child: Text("Some Text")), 
                    SizedBox(height: 15),
                    Center(child:ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        } , 
                      child: Container(
                        width: size.width/3,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Logout"),
                          SizedBox(width: 10),
                          Icon(Icons.logout_outlined)
                        ]
                      ))))
                  ],
                )
              ),
              SizedBox(
                height: 20
              ),
              Container(
                width: size.width/1.05,
                child: ElevatedButton(
                  style: ButtonStyle(
                  backgroundColor:  MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
                            shape:  MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )
                              )
                ),
                onPressed: (){}, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Feel Free to Tell us ABout Your Challenges",
                      style: TextStyle(
                        fontSize: 15,
                        //fontWeight: FontWeight.bold,
                        color:  Colors.white
                      ),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.rocket_launch_outlined),
                  ],
                )))
          ]
        ),
      ),
    );
  }
}