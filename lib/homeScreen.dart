import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/singleProduct.dart';
import 'package:trainapp/filterOptions.dart';

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
                      isMinimized = true;
                      xOffset = 200;
                      yOffset = 120;
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
                    child: Icon(Icons.settings),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
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
                                  height: 60,
                                  width: 60,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
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
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.23,
                                child: Image.asset(
                                  productList[index].picture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadowList,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    )),
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2,
                                //width: MediaQuery.of(context).size.width*0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
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
                                    Text(productList[index].location),
                                  ],
                                ),
                              ),
                            )
                          ],
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
