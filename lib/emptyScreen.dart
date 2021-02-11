import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';

class EmptyScreen extends StatefulWidget {
  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  //ViewProduct viewProduct;
  int selectedItem = 0;
  bool isMinimized = true;
  double xOffset = 180;
  double yOffset = 150;
  double scaleFactor = 0.7;
  bool showNumber = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
          BorderRadius.all(Radius.circular(isMinimized ? 18 : 0))),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 250),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
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
                      isMinimized = true;
                      xOffset = 170;
                      yOffset = 140;
                      scaleFactor = 0.7;
                    });
                  },
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
                          style: TextStyle(fontFamily: 'Genuine', fontSize: 18),
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
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>Filters()));
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
                                      horizontal: 10, vertical: 5),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                                        fontWeight: FontWeight.w700),
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

                child: ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: ((context, index) {
                    final product = productList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return SingleProduct(product: product,);
                        },));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                          height:
                          MediaQuery
                              .of(context)
                              .size
                              .height * 0.2,
                          //width: MediaQuery.of(context).size.width*0.5,
                          child: Row(
                            children: <Widget>[
                              Container(

                                margin:EdgeInsets.only(right:12),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                    BorderRadius.only(topLeft:Radius.circular(35),bottomLeft:Radius.circular(35))),
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.3,
                                child: ClipRRect(
                                  borderRadius:BorderRadius.only(topLeft:Radius.circular(15), bottomLeft:Radius.circular(15)),
                                  child: Image.asset(
                                    productList[index].picture,
                                    fit: BoxFit.cover,
                                    height:MediaQuery.of(context).size.height*0.3,
                                    width:MediaQuery.of(context).size.width*0.38
                                  ),
                                ),
                              ),
                              Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10,),
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
                                    alignment:Alignment.bottomRight,
                                    child: Row(
                                      children: <Widget>[
                                        Text(productList[index].location),

                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          height: MediaQuery.of(context).size.height*0.065,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: primaryGreen,),
                                          padding: EdgeInsets.all(5),
                                            child: showNumber ? Text(productList[index].productName)
                                                : IconButton(icon: Icon(Icons.call),iconSize:20,alignment:Alignment.center,color: Colors.white, onPressed: () {},),

                                        )
                                      ],
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
