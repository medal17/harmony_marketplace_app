import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/drawerScreen.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

Future<void> _launcher(String value) async {
  // const url = value;
  if (await canLaunch(value)) {
    await launch(value);
  } else {
    throw 'Could not Call $value';
  }
}

class _WishListState extends State<WishList> {
  //ViewProduct viewProduct;
  int selectedItem = 0;
  bool isMinimized = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool showNumber = false;
  var snapshot1;

  void getData() async {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    //use a Async-await function to get the data
    print(authNotifier.user.email);
    final data = await Firestore.instance
        .collection("wishList")
        .where('user', isEqualTo: authNotifier.user.email)
        .snapshots(); //get the data
    snapshot1 = data;
    // print(data);
  }

  // Firestore.instance
  //     .collection('messages')
  //     .where('sender', isEqualTo: 'iyandaadeshina@gmail.com')
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    getData();
    // print(snapshot.data.productId);
    // Stream myWishes = Firestore.instance
    //     .collection('wishList')
    //     .where('user', isEqualTo: 'iyandaadeshina@gmail.com')
    //     .snapshots();

    return Scaffold(
      body: AnimatedContainer(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius:
                BorderRadius.all(Radius.circular(isMinimized ? 18 : 0))),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: Duration(milliseconds: 250),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 22, horizontal: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isMinimized
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              isMinimized = false;
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 25,
                            color: primaryGreen,
                          ),
                          onPressed: () {
                            setState(() {
                              DrawerScreen();
                              isMinimized = true;
                              xOffset = 200;
                              yOffset = 120;
                              scaleFactor = 0.7;
                            });
                          },
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Icon(
                      //   Icons.favorite_border,
                      //   color: primaryGreen,
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      Text(
                        'My WishList',
                        style: TextStyle(fontFamily: 'Genuine', fontSize: 16),
                      ),
                    ],
                  ),
                  CircleAvatar(),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(Icons.search),
                    Text('Search for products'),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Filters()));
                      },
                      child: Icon(Icons.search),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: StreamBuilder(
                      stream: snapshot1,

                      // Firestore.instance
                      //     .collection("product")
                      //     .document('H72sfDgCj3lfUQHj0ChQ')
                      //     .snapshots(),
                      builder: (context, snapshot) {
                        return StreamBuilder(
                            stream: Firestore.instance
                                .collection("wishList")
                                .where('user',
                                    isEqualTo: authNotifier.user.email)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == 'true') {
                                return Center(
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(
                                          backgroundColor: primaryGreen,
                                        ),
                                        Text('Loading Data')
                                      ],
                                    ),
                                    height: 60,
                                    width: 60,
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.broken_image),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('${snapshot.error}')
                                    ],
                                  ),
                                );
                              }
                              // print(myProducts[myProducts.length]['productId']);
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: ((context, index) {
                                  // print(snapshot1.data.documents[index]
                                  //     ['productId']);
                                  final product =
                                      snapshot.data.documents[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (_) {
                                          return SingleProduct(
                                            product: product,
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: shadowList,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        alignment: Alignment.topLeft,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        height: 105,
                                        //width: MediaQuery.of(context).size.width*0.5,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin:
                                                  EdgeInsets.only(right: 12),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueGrey,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15))),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    bottomLeft:
                                                        Radius.circular(15)),
                                                child: CachedNetworkImage(
                                                    imageUrl: product[
                                                                'picture1'] !=
                                                            ''
                                                        ? product['picture1']
                                                        : '',
                                                    fit: BoxFit.cover,
                                                    placeholder: (context,
                                                            url) =>
                                                        CircularProgressIndicator(),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.3,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3),
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                    product['title'],
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: primaryGreen),
                                                  ),
                                                ),
                                                product['title'].length < 20
                                                    ? SizedBox(
                                                        height: 12,
                                                      )
                                                    : SizedBox(
                                                        height: 1,
                                                      ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_rounded,
                                                        size: 17,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        productList[index]
                                                            .location,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'montserrat',
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 2,
                                                // ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.54,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 3,
                                                          child: Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: Text(
                                                                product[
                                                                    'price'],
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Genuine',
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w200),
                                                              )),
                                                        ),
                                                        Expanded(
                                                          child: showNumber
                                                              ? Text(productList[
                                                                      index]
                                                                  .productName)
                                                              : IconButton(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  icon: Icon(Icons
                                                                      .message_rounded),
                                                                  iconSize: 20,
                                                                  // alignment: Alignment.center,
                                                                  color:
                                                                      primaryGreen,
                                                                  onPressed:
                                                                      () {
                                                                    _launcher(product[
                                                                            'phone']
                                                                        .toString());
                                                                  },
                                                                ),
                                                        ),
                                                        Expanded(
                                                          child: showNumber
                                                              ? Text(productList[
                                                                      index]
                                                                  .productName)
                                                              : IconButton(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              3),
                                                                  icon: Icon(
                                                                      Icons
                                                                          .call),
                                                                  iconSize: 20,
                                                                  // alignment: Alignment.center,
                                                                  color:
                                                                      primaryGreen,
                                                                  onPressed:
                                                                      () {
                                                                    _launcher('234' +
                                                                        product[
                                                                            'phone']);
                                                                  },
                                                                ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            });
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
