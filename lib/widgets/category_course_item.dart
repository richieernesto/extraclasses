import 'dart:io';

import 'package:extra_classes/model/channel_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../screens/course_info_screen.dart';

class CategoryCardItem extends StatefulWidget {
  final String courseTitle;
  final String courseAuthor;
  final double coursePrice;
  final String courseClass;
  final String imgUrl;

  CategoryCardItem(
    @required this.courseTitle,
    @required this.courseAuthor,
    @required this.coursePrice,
    @required this.courseClass,
    @required this.imgUrl
  );

@override
_CategoryCardItemState createState() =>_CategoryCardItemState();
}
class _CategoryCardItemState extends State<CategoryCardItem>{
  
  @override
  Widget build(BuildContext context) {
    currency(context){
      Locale locale = Localizations.localeOf(context);
      var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: "GHS");
      return format;
    }
    return Stack(
      children: [
        Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CourseInfoScreen(
                  product_title: widget.courseTitle, 
                  thumbnail_url: widget.imgUrl, 
                  price: widget.coursePrice, 
                  description: "Lorem Ipsum"),));
              },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(239, 239, 238, 1),
                borderRadius: BorderRadius.circular(12),

              ),
              width: MediaQuery.of(context).size.width/1.95,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: Column(             
                children: [
                  Text(widget.courseTitle,
                  textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, 
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                    
                  ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(widget.courseAuthor, style:TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(
                    widget.courseClass
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("${currency(context).currencySymbol } $widget.coursePrice",)),
                ],
              ),
            ),)
          ],
        ),
        Positioned(
          top: 10,
          //right: 80,
          bottom: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),

            ),
            width: 65,
            height: MediaQuery.of(context).size.width/9,
            //must be loaded with course image
            child:  Image.network(widget.imgUrl),
          ),
        )
      ],
      clipBehavior: Clip.none,
      //alignment: Alignment.centerRight,
    );
  }
}
