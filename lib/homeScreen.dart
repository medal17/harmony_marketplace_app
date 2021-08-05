import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/chat.dart';
import 'package:trainapp/api/Firebase_Api.dart';
import 'package:trainapp/messenger_list.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';
// import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //ViewProduct viewProduct;
  int selectedItem = 0;
  bool isMinimized = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool showNumber = false;
  StorageReference storageReference = FirebaseStorage.instance.ref();

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch('tel:${url}')) {
      await launch('tel:${url}');
    } else {
      throw 'Could not launch $url';
    }
  }

  final format = new NumberFormat("#,##0", "en_US");
// Future<void>? _launched;
  @override
  Widget build(BuildContext context) {
    getMessage();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    Locale locale = Localizations.localeOf(context);

    return AnimatedContainer(
      decoration: BoxDecoration(
          boxShadow: shadowListBlack,
          color: Colors.grey[200],
          borderRadius:
              BorderRadius.all(Radius.circular(isMinimized ? 18 : 0))),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Stack(children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 22,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
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
                        : Container(
                            margin: EdgeInsets.only(left: 5),
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: 25,
                                color: primaryGreen,
                              ),
                              onPressed: () {
                                setState(() {
                                  isMinimized = true;
                                  xOffset = 200;
                                  yOffset = 120;
                                  scaleFactor = 0.7;
                                });
                              },
                            ),
                          ),
                    Column(
                      children: <Widget>[
                        Text('Location'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.add_location,
                              color: primaryGreen,
                            ),
                            Text(
                              'Ukraine',
                              style: TextStyle(
                                  fontFamily: 'Genuine', fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(18))),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                      child: Icon(
                        Icons.filter_list,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItem = index;
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: index == selectedItem
                                            ? primaryGreen
                                            : Colors.white,
                                        boxShadow: shadowList,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        )),
                                    height: 45,
                                    width: 45,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: categories[index],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Text(
                                      menuTag[index].toString(),
                                      style: TextStyle(
                                          color: index == selectedItem
                                              ? primaryGreen
                                              : Colors.blueGrey,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 12,
                                          fontFamily: 'Genuine'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white.withOpacity(0.5),
                  child: StreamBuilder(
                      stream:
                          Firestore.instance.collection('product').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: ((context, index) {
                              final product = snapshot.data.documents[index];
                              // print(product['phone']);

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
                                                    Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 15),
                                                        child:
                                                            CircularProgressIndicator()),
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
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 3),
                                                      child: Text(
                                                        'NGN ',
                                                        style: TextStyle(
                                                            fontSize: 11),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            '${format.format(int.parse(product['price']))}',
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
                                                        icon: Icon(Icons
                                                            .message_rounded),
                                                        iconSize: 20,
                                                        // alignment: Alignment.center,
                                                        color: primaryGreen,
                                                        onPressed: () {
                                                          _makePhoneCall(
                                                              product['phone']
                                                                  .toString());
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        icon: Icon(Icons.call),
                                                        iconSize: 20,
                                                        // alignment: Alignment.center,
                                                        color: primaryGreen,
                                                        onPressed: () {
                                                          _makePhoneCall(
                                                              product['phone']);
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
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 5),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: primaryGreen,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MessengerList()));
            },
            child: Icon(
              Icons.notifications,
              size: 18,
            ),
          ),
        )
      ]),
    );
  }
}
