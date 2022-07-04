import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra_classes/model/channel_info.dart';
import 'package:extra_classes/model/firebase_channelIdSnapshot.dart';
import 'package:extra_classes/model/video_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import '../model/Api_service.dart';
import '../widgets/category_course_item.dart';
import '../widgets/popular_course_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ChannelInfo _channelInfo = ChannelInfo();
  VideosList _videosList = VideosList();
  ScrollController? _scrollController;
  Item _item = Item();
  bool _isloading = true;
  final String _playtlistidd = "";
  String _nextTokenPage = "";
  List<String> _channelIdlistcollector = [];
  //UserInformation _information = UserInformation();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();
  List<String> dataList2 = ["UCsNrLT-M03lvshUuilSJ8XA","UComQiXI7rnjwVU8b6x5epGw"];
  @override
  void initState() {
    super.initState();
    _isloading = true;
    _scrollController = ScrollController();
    _videosList.videos = [];

    _getchannel();
  }

  _getchannel() async {
    //_channelIdlistcollector = (await _information.getDataFromFirebase()) as List<String>;
    // problem identified here

    _channelInfo = (await API_Service.instance.fetchChannelDetails(dataList2));

    _item = _channelInfo.items![0];
    print(_item.snippet);

    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        //Insert Username here
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Hi User",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Categories",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25),
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
                            height: MediaQuery.of(context).size.height / 6.5,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: dataList2.length,
                                itemBuilder: (context, index) {
                                  return CategoryCardItem(
                                      "Mathematics",
                                      "Mr. Abu",
                                      40.00,
                                      "Basic 3",
                                      _item.snippet!.thumbnails!.medium!.url ??
                                          "");
                                })),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Popular Subjects",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        GridView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          padding: EdgeInsets.all(5),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          children: [
                            PopularCourseCard(
                                courseTitle: "English Language",
                                coursePrice: 35,
                                courseClass: "Basic 3",
                                imgLocation:
                                    "lib/assets/images/english_img.jpg"),
                            PopularCourseCard(
                                courseTitle: "English Language",
                                coursePrice: 35,
                                courseClass: "Basic 3",
                                imgLocation:
                                    "lib/assets/images/english_img.jpg"),
                            PopularCourseCard(
                                courseTitle: "English Language",
                                coursePrice: 35,
                                courseClass: "Basic 3",
                                imgLocation:
                                    "lib/assets/images/english_img.jpg"),
                            PopularCourseCard(
                                courseTitle: "English Language",
                                coursePrice: 35,
                                courseClass: "Basic 3",
                                imgLocation:
                                    "lib/assets/images/english_img.jpg"),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
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
      ))),
      onPressed: () {},
      child: Text(btnText),
    );
  }
}
