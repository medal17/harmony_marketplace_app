import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/drawerScreen.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';

import 'notifier/Auth_Notifier.dart';

class MyProduct extends StatefulWidget {
  @override
  _MyProductState createState() => _MyProductState();
}

Future<void> _launcher(String value) async {
  // const url = value;
  if (await canLaunch(value)) {
    await launch(value);
  } else {
    throw 'Could not Call $value';
  }
}

final snackBar = SnackBar(
  content: Text('Delete! Confirm you wish to delete!'),
  action: SnackBarAction(
    label: 'Undo',
    onPressed: () {
      // Some code to undo the change.
    },
  ),
);

class _MyProductState extends State<MyProduct> {
  //ViewProduct viewProduct;
  int selectedItem = 0;
  bool isMinimized = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool showNumber = false;

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
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
                        'My Products',
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
                    // Icon(Icons.search),
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
                      stream: Firestore.instance
                          .collection('product')
                          .where('sellerId', isEqualTo: authNotifier.user.email)
                          .snapshots(),
                      builder: (context, snapshot) {
                        print(Firestore.instance
                            .collection('product')
                            .snapshots());
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: ((context, index) {
                            final product = snapshot.data.documents[index];

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
                              child: Dismissible(
                                onDismissed: (direction) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text('deleted')));
                                },
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.delete_outline_outlined,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                      Icon(
                                        Icons.delete_outline_outlined,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      // boxShadow: shadowList,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                key: Key(product['productName']),
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
                                          margin: EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                              color: Colors.blueGrey,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft:
                                                      Radius.circular(15))),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft:
                                                    Radius.circular(15)),
                                            child: CachedNetworkImage(
                                                imageUrl: product['picture1'],
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.3,
                                                width: MediaQuery.of(context)
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
                                                    fontFamily: 'montserrat',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
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
                                              alignment: Alignment.bottomRight,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_rounded,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    productList[index].location,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'montserrat',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
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
                                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            product['price'],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Genuine',
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200),
                                                          )),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        icon: Icon(
                                                            Icons.edit_rounded),
                                                        iconSize: 20,
                                                        // alignment: Alignment.center,
                                                        color: primaryGreen,
                                                        onPressed: () {
                                                          _launcher(
                                                              product['phone']
                                                                  .toString());
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        icon: Icon(Icons
                                                            .delete_sweep_rounded),
                                                        iconSize: 20,
                                                        // alignment: Alignment.center,
                                                        color: primaryGreen,
                                                        onPressed: () {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              action:
                                                                  SnackBarAction(
                                                                label: 'Action',
                                                                onPressed: () {
                                                                  // Code to execute.
                                                                },
                                                              ),
                                                              content: const Text(
                                                                  'Confirm you wish to Delete'),
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1500),
                                                              width:
                                                                  280.0, // Width of the SnackBar.
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal:
                                                                    8.0, // Inner padding for SnackBar content.
                                                              ),
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                            ),
                                                          );
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
                              ),
                            );
                          }),
                        );
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
