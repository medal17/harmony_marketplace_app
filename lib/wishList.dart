import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/drawerScreen.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  //ViewProduct viewProduct;
  int selectedItem = 0;
  bool isMinimized = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool showNumber = false;

  @override
  Widget build(BuildContext context) {
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
                            Icons.menu,
                            size: 28,
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
                      Icon(
                        Icons.favorite_border,
                        color: primaryGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'My WishList',
                        style: TextStyle(fontFamily: 'Genuine', fontSize: 22),
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
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: ((context, index) {
                      final product = productList[index];
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
                          key: Key(product.productName),
                          //confirmDismiss: (direction) =>promptUser(direction),
                          onDismissed: (direction) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('deleted')));
                          },
                          background: Container(
                            color: Colors.red,
                          ),
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
                              height: 105,
                              //width: MediaQuery.of(context).size.width*0.5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(35),
                                              bottomLeft: Radius.circular(35))),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                        child: Image.asset(
                                            productList[index].picture,
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.38),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          productList[index].productName,
                                          style: TextStyle(
                                              fontFamily: 'genuine',
                                              fontSize: 23,
                                              color: primaryGreen),
                                        ),
                                        Text(
                                          productList[index].productPrice,
                                          style: TextStyle(
                                              fontFamily: 'montserrat',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Container(
                                            //width: MediaQuery.of(context).size.width*0.2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(productList[index]
                                                    .location),
                                                SizedBox(width: 15),
                                                showNumber
                                                    ? Text(productList[index]
                                                        .productName)
                                                    : IconButton(
                                                        icon:
                                                            Icon(Icons.delete),
                                                        iconSize: 25,
                                                        alignment:
                                                            Alignment.center,
                                                        color: primaryGreen,
                                                        onPressed: () {},
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
