import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:trainapp/model/modelData.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier with ChangeNotifier {
  FirebaseUser _user;
  FirebaseUser get user => _user;
  bool signInStatus = false;
  String signInMessage = '';

  void setUser(FirebaseUser user) {
    // print(user.uid.toString());
    _user = user;
    notifyListeners();
  }

  void setSignInStatus(bool value) {
    // print(user.uid.toString());
    signInStatus = value;
    notifyListeners();
  }

  void setSignInMessage(String value) {
    // print(user.uid.toString());
    signInMessage = value;
    notifyListeners();
  }
}
