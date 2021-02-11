import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/widgets.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    
  //FirebaseFirestore inst = FirebaseFirestore.instance;
  _launcher() async {
    const url = 'tel: +234 802 370 8417';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Call $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen:false);
    print(authNotifier.user);

    return  AnimatedContainer(
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
                        : Container(
                          margin:EdgeInsets.only(left:70),
                          child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: 38,
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
                              style:
                                  TextStyle(fontFamily: 'Genuine', fontSize: 18),
                            ),
                          ],
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
                        child: Icon(Icons.filter_list),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 100,
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
                                            Radius.circular(15),
                                          )),
                                      height: 55,
                                      width: 55,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: categories[index],
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      child: Text(
                                        menuTag[index].toString(),
                                        style: TextStyle(
                                            color: index == selectedItem
                                                ? primaryGreen
                                                : Colors.blueGrey,
                                            fontWeight: FontWeight.w500),
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
                    color: Colors.white,
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('product').snapshots(),
                      builder: (context, snapshot) {
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
                              child: Container(
                                margin: EdgeInsets.only(top: 7),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: shadowList,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  //width: MediaQuery.of(context).size.width*0.5,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                bottomLeft: Radius.circular(15))),
                                        height:
                                            MediaQuery.of(context).size.height * 0.3,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                          child: CachedNetworkImage(                               
                                          imageUrl:product['picture1'],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url)=>CircularProgressIndicator(),
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.3,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.38),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
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
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: primaryGreen),
                                            ),
                                          ),
                                          product['title'].length < 20
                                              ? SizedBox(
                                                  height: 12,
                                                )
                                              : SizedBox(height: 1,),
                                          Text(
                                            product['price'],
                                            style: TextStyle(
                                                fontFamily: 'montserrat',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: 150,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Expanded(
                                                                                                child: Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: Text(productList[index].location)),
                                                  ),
                                                  Expanded(
                                                                                                child: Container(
                                                      alignment: Alignment.bottomRight,
                                                      margin: EdgeInsets.only(left: 30),
                                                      height: MediaQuery.of(context).size.height *0.063,
                                                      width: MediaQuery.of(context).size.height *0.063,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(10)),
                                                        color: primaryGreen,
                                                      ),
                                                      padding: EdgeInsets.all(3),
                                                      child: showNumber
                                                          ? Text(productList[index]
                                                              .productName)
                                                          : IconButton(
                                                        padding: EdgeInsets.all(5),
                                                              icon: Icon(Icons.call),
                                                              iconSize: 20,
                                                             // alignment: Alignment.center,
                                                              color: Colors.white,
                                                              onPressed: () {
                                                                _launcher();
                                                              },
                                                            ),
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
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10, bottom: 5),
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: primaryGreen,
              onPressed: () {},
              child: Icon(Icons.notifications),
            ),
          )
        ]),
      );
  }
}
