import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/model/userModel.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';

//String status = '';
login(LocalUser user, AuthNotifier authNotifier) async {
  final result = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) {
    authNotifier.setSignInStatus(false);
    authNotifier.setSignInMessage(error.message);
    print(error.message);
  });

  FirebaseUser firebaseUser = result.user;

  if (firebaseUser != null) {
    print(result.user);
    print("Log in: $firebaseUser");
    authNotifier.setUser(firebaseUser);
    authNotifier.setSignInStatus(false);
  }
}

signup(LocalUser user, AuthNotifier authNotifier) async {
  var result = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (result != null) {
    Firestore.instance.collection('users').add({
      "name": user.userName,
      "email": user.email,
      "password": user.password
    }).then((value) => print('success'));
    //UserInfo updateInfo = UserInfo();
    //updateInfo.displayName = user.displayName;

    FirebaseUser firebaseUser = result.user;
    if (firebaseUser != null) {
      //firebaseUser.updateProfile;
      await firebaseUser.reload();
      print("Sign up: $firebaseUser");

      // Navigator.push((context), MaterialPageRoute(builder:(_)=>GateWay()));
      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
  if (firebaseUser != null) {
    authNotifier.setUser(firebaseUser);
    print(firebaseUser);
  }
}

createProduct(LocalUser _user, Products product) async {
  //DocumentReference firestore =
  await Firestore.instance
      .collection('product')
      .add({
        'sellerId': product.sellerId,
        'Description': product.productDescription,
        'price': product.productPrice,
        'type': product.type,
        'category': product.category,
        'picture1': product.picture,
        'title': product.productName,
        'negotiable': product.negotiable
      })
      .then((value) => print('Product Inserted'))
      .catchError((error) => print(error.code));
}

getMessage() async {
  List messages = new List();
  //DocumentReference firestore =
  final result = await Firestore.instance
      .collection('messages')
      .where('sender', isEqualTo: 'iyandaadeshina@gmail.com')
      .getDocuments()
      .then((value) async {
    final result1 = await Firestore.instance
        .collection('messages')
        .where('reciever', isEqualTo: 'iyandaadeshina@gmail.com')
        .getDocuments()
        .then((value) {
      for (int i = 0; i < value.documents.length; i++) {
        messages.add(value.documents[i].data);
        // print(messages.length);
      }
    });
    for (int i = 0; i < value.documents.length; i++) {
      messages.add(value.documents[i].data);
      // print(messages);
    }
  });
  // print(result);
  print(messages);

  return messages;
}
