//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';
import 'package:provider/provider.dart';
//import 'package:trainapp/model/modelData.dart';

class SingleProduct extends StatelessWidget {
  final product;
  //final ViewProduct viewProduct;
  SingleProduct({this.product});

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    print(authNotifier.user.email);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned.fill(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blueGrey,
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: CachedNetworkImage(
                    imageUrl: product['picture1'],
                    fit: BoxFit.fill,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    //product['picture1'],
                    //'images/shirt.jpg',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(fontFamily: 'genuine', fontSize: 14),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(product['Description']),
                    // Text(product['number']),
                  ],
                ),
              ),
            )
          ],
        )),
        Container(
          //padding: EdgeInsets.only(top: 15),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              color: Colors.blueGrey.withOpacity(0.7),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ),
        ),
        /*Container(
          padding: EdgeInsets.only(right: 10),
          child: CachedNetworkImage(
            imageUrl: product['picture1'], 
            fit: BoxFit.fill,
            placeholder: (context,url)=>CircularProgressIndicator(),
              //product['picture1'],
              //'images/shirt.jpg',
             
            ),
        ),*/
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 90,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          product['title'],
                          style: TextStyle(
                              fontFamily: 'genuine',
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                      Text('2 days Ago',
                          style: TextStyle(
                              fontFamily: 'genuine',
                              fontSize: 14,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        product['type'],
                        style: TextStyle(fontFamily: 'genuine', fontSize: 17),
                      ),
                      Text('-N- ' + product['price'],
                          style: TextStyle(
                              fontFamily: 'genuine',
                              fontSize: 16,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(15)),
              child: authNotifier.user.email == product['sellerId']
                  ? Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red[700],
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            height: 50,
                            width: 60,
                            child: Center(
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontFamily: 'genuine',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.yellow[900],
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   width: 10,
                                // ),
                                Text(
                                  'Sold',
                                  style: TextStyle(
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(10)),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 50,
                          width: 60,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryGreen,
                                borderRadius: BorderRadius.circular(17)),
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Show Interest',
                                  style: TextStyle(
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.circular(20)),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          height: 50,
                          width: 60,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    )),
        )
      ],
    ));
  }
}
