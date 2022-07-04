import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserInformation {

String ?channelId;

UserInformation( 
  this.channelId
);
factory UserInformation.fromMap(Map<String,dynamic> json){
  return UserInformation(
      json['channelId']
  );
  
}

}
