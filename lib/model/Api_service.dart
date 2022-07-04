import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra_classes/constant_utils.dart/Api_key.dart';
import 'package:extra_classes/model/channel_info.dart';
import 'package:extra_classes/model/video_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart';

class API_Service {
  static const _baseUrl = "www.googleapis.com";
  static const channelId = "UComQiXI7rnjwVU8b6x5epGw";

  API_Service._instantiate();

  static final API_Service instance = API_Service._instantiate();
  Stream _usersStream =
      FirebaseFirestore.instance.collection("users").snapshots();
  // get the channelId from the database
//Future <dynamic> getDataFromFirebase(){
  //UComQiXI7rnjwVU8b6x5epGw
  var channelInfo;
//}
  //take a list of the item
  // loop through the item to get
// Uri  ?uri;
  //Map<String,String>? headers;
  //supposed to return a list at this place

  Future  <ChannelInfo> fetchChannelDetails(List<String> list) async {
    for (int i = 0; i < list.length; i++) {
      Map<String, String> parameters = {
        'part': 'snippet,contentDetails,statistics',
        'id': list[i],
        'key': API_KEY
      };
      Uri uri = Uri.https(_baseUrl, '/youtube/v3/channels', parameters);
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      // get the Channnel.
      Response response = await http.get(uri, headers: headers);
      print(response.body);
      channelInfo = channelInfoFromJson(response.body);
      //return channelInfo;
      print( channelInfo);
    
    }
  return channelInfo;
    
  }

  Future<VideosList> fetchVideosFromPlaylist(
      {String? playlistId, String? nextpageTT}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId!,
      'maxResults': '8',
      'pageToken': nextpageTT!,
      'key': API_KEY
    };
    Uri uri = Uri.https(_baseUrl, '/youtube/v3/playlistItems', parameters);
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    Response response = await http.get(uri, headers: headers);
    print(response.body);
//print(data)
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
