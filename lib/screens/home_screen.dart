import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/category_course_item.dart';
import '../widgets/popular_course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView( 
        child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                //Insert Username here
                Align(
                  alignment:Alignment.centerLeft,
                  child: Text("Hi User", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),),
                SizedBox(
                  height: 20,
                ),
                Text("Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25
                  ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  
                    CategoryButton("Basic 1"),
                    CategoryButton("Basic 2"),
                    CategoryButton("Basic 3")
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/6.5,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCardItem(
                      "Mathematics",
                      "Mr. Abu",
                      40.00,
                      "Basic 3",
                      "lib/assets/images/bgimage2.jpg"
                    ),
                    CategoryCardItem(
                      "Mathematics",
                      "Mr. Abu",
                      20.00,
                      "Basic 6",
                      "lib/assets/images/bgimage2.jpg"
                    ),
                    CategoryCardItem(
                      "Mathematics",
                      "Mr. Abu",
                      20.00,
                      "Basic 4",
                      "lib/assets/images/bgimage2.jpg"
                    )
                  ]
                ),),
                SizedBox(
                  height: 25,
                ),
                Text("Popular Subjects",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                GridView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
            padding: EdgeInsets.all(5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2           
              ),
            children: [
            PopularCourseCard(
              courseTitle: "English Language", 
              coursePrice: 35, 
              courseClass: "Basic 3", 
              imgLocation: "lib/assets/images/english_img.jpg"),
               PopularCourseCard(
              courseTitle: "English Language", 
              coursePrice: 35, 
              courseClass: "Basic 3", 
              imgLocation: "lib/assets/images/english_img.jpg"),
               PopularCourseCard(
              courseTitle: "English Language", 
              coursePrice: 35, 
              courseClass: "Basic 3", 
              imgLocation: "lib/assets/images/english_img.jpg"),
               PopularCourseCard(
              courseTitle: "English Language", 
              coursePrice: 35, 
              courseClass: "Basic 3", 
              imgLocation: "lib/assets/images/english_img.jpg"),
          ],
          )
              ],
            ),
          ),
          
        ],
      ),
    ),);
  }
}

class CategoryButton extends StatelessWidget {
  final String btnText;

  CategoryButton(@required this.btnText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    style: ButtonStyle(
     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      //side: BorderSide(color: Colors.red)
    )
     )
    ) ,
    onPressed: (){}, 
    child: Text(
      btnText
    ),);
  }
}

