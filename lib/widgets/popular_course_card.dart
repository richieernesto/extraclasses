import 'package:flutter/material.dart';

import '../screens/course_info_screen.dart';

class PopularCourseCard extends StatelessWidget {
  final String courseTitle;
  final double coursePrice;
  final String courseClass;
  //final String courseTutor;
  final String imgLocation;

  PopularCourseCard({
    required this.courseTitle,
    required this.coursePrice,
    required this.courseClass,
    //required this.courseTutor,
    required this.imgLocation
  });
  

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height/4,
      width: screenSize.width/2.5,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CourseInfoScreen(
            product_title: courseTitle, 
            thumbnail_url: imgLocation, 
            price: coursePrice, 
            description: "Put Product description here ") ));
        },
        child: ClipRect(
          clipBehavior: Clip.none,
          child: SizedBox(
            
          //margin: EdgeInsets.all(5),
            child: Column(
              children: [
                Flex(direction: Axis.vertical,
              children: [
                Text(
                courseTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
                ),
                SizedBox(),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [                  
                    Text(
                      courseClass
                    ),
                    Text(
                      "GH₵$coursePrice",
                      style: TextStyle(
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
                Container(
                  height: screenSize.height/6,
                  width: screenSize.width/2.9,
                  margin: EdgeInsets.all(6),
                  child:Image.asset(imgLocation)
                )
              ],
            )
        ]),
      ),),
    ));
  }
}