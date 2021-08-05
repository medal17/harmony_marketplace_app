import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/api/Firebase_Api.dart';
import 'config file.dart';

import 'notifier/Auth_Notifier.dart';
//import 'package:trainapp/model/userModel.dart';

class EditMyProduct extends StatelessWidget {
  String description;
  String address;
  String city;
  String phone;
  String price;
  String id;
  EditMyProduct({this.description, this.address, this.city, this.phone, this.id, this.price});
  // final string location;
  // final shot;
  // ProfileForm();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController(text: description);
    TextEditingController addressController =
        TextEditingController(text: address);
    TextEditingController cityController = TextEditingController(text: address);
    TextEditingController phoneController = TextEditingController(text: phone);
    TextEditingController priceController = TextEditingController(text: price);
    // shot.toString();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);

    updateProfile() {
      Firestore.instance.collection('users').document(id).updateData({
        "Name": userController.text,
        "Location": addressController.text,
        "Phone": phoneController.text
      });
    }

    // print(id);
    //var newUser = NewUser();
    // Stream shot = Firestore.instance.collection('users').document(
    //     // 'iyandaadeshina@gmail.com'
    //     authNotifier.user.uid).snapshots();
    // print(shot);
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: primaryGreen.withOpacity(0.9),
        title: Text(
          'Edit Product',
          style: TextStyle(fontSize: 14),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height * .6,
                  // color: Colors.blueGrey[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 40),
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 13),
                      //   child: Text(
                      //     'Edit Profile',
                      //     style: TextStyle(
                      //         fontFamily: 'genuine',
                      //         fontWeight: FontWeight.w200,
                      //         fontSize: 25,
                      //         color: primaryGreen),
                      //   ),
                      // ),
                      // Text(authNotifier.signInMessage.toString(),
                      //     style: TextStyle(
                      //         fontFamily: 'genuine',
                      //         fontWeight: FontWeight.w200,
                      //         color: Colors.red)),
                      Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  //obscureText: true,
                                  //keyboardType: Keyboar,
                                  controller: userController,
                                  // initialValue: user.toString(),
                                  decoration: InputDecoration(
                                    labelText: 'Product Description',
                                    labelStyle: TextStyle(fontSize: 14),
                                    // focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Input your Description';
                                    }
                                    if (value.length < 5) {
                                      return 'Username must be between 5 and 12';
                                    }
                                    return null;
                                  },
                                  onSaved: (String value) {
                                    // _user.email = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        // padding: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.symmetric(vertical: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  // initialValue: address,
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    labelText: 'Location',
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Input your Password';
                                  //   }
                                  //   if (value.length < 5 || value.length > 12) {
                                  //     return 'Password must be between 5 and 12';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (String value) {
                                    // _user.password = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        // padding: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.symmetric(vertical: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 52,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  // initialValue: address,
                                  controller: cityController,
                                  decoration: InputDecoration(
                                    labelText: 'City',
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Input your Password';
                                  //   }
                                  //   if (value.length < 5 || value.length > 12) {
                                  //     return 'Password must be between 5 and 12';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (String value) {
                                    // _user.password = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        // padding: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.symmetric(vertical: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  // initialValue: phone,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    labelText: 'Category',
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Input your Password';
                                  //   }
                                  //   if (value.length < 5 || value.length > 12) {
                                  //     return 'Password must be between 5 and 12';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (String value) {
                                    // _user.password = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 70,
                        // padding: EdgeInsets.only(bottom: 5),
                        padding: EdgeInsets.symmetric(vertical: 3),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(7)),
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextFormField(
                                  style: TextStyle(fontSize: 14),
                                  // initialValue: phone,
                                  controller: priceController,
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                  // validator: (String value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Input your Password';
                                  //   }
                                  //   if (value.length < 5 || value.length > 12) {
                                  //     return 'Password must be between 5 and 12';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (String value) {
                                    // _user.password = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          if (!authNotifier.signInStatus) {
                            updateProfile();
                            authNotifier.setSignInStatus(true);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 40),
                          child: authNotifier.signInStatus
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Update Product',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 20),
                                ),
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
