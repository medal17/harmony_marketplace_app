import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
//import 'package:trainapp/model/modelData.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class AuthNotifier with ChangeNotifier{
  FirebaseUser _user;
  FirebaseUser get user => _user;

  void setUser(FirebaseUser user){  
    _user = user;
    notifyListeners();
  }
}