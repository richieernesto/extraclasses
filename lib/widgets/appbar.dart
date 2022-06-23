import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({
    Key? key,
  }) : super(key: key);
  Size get preferredSize =>Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottomOpacity: 0,
      shadowColor: Colors.white ,
      elevation: 0,
      title: const Text("Extra Classes", style: TextStyle(
        color: Colors.black
      ),),
      actions: [
        IconButton(onPressed: (){
          showSearch(context: context, delegate: CustomSearchDelegate());
        }, icon: Icon(Icons.search),
        color: Colors.black,)
      ],
      backgroundColor: Colors.white
      //Theme.of(context).backgroundColor,
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchItems = [
    'Mathematics',
    'English for Primary 6',
    'Integrated Science for JHS 1',
    'Social Studies for JHS 2',
    "Ghanaian Language(Ga) for JHS 3"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      //For Clearing The Query
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  //For Leaving the Search Bar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    //example of looping through list
    for (var course in searchItems) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
        itemCount: matchQuery.length);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    //example of looping through list
    for (var course in searchItems) {
      if (course.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(course);
      }
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        },
        itemCount: matchQuery.length);
  }
}