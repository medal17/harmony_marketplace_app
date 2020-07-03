import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/model/modelData.dart';

class SingleProduct extends StatefulWidget {
  final Products product;
  //final ViewProduct viewProduct;
  SingleProduct({this.product});
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Positioned.fill(
            child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blueGrey,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                //schild: Image.asset('images/phone.jpg'),
              ),
            )
          ],
        )),
        Container(
          margin: EdgeInsets.only(top: 30, left: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
        Container(
          child: Image.asset(
            'images/phone.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 140,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: shadowList,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Nokia 3310',
                        style: TextStyle(fontFamily: 'genuine', fontSize: 30),
                      ),
                      Text('15,200 naira',
                          style: TextStyle(
                              fontFamily: 'genuine',
                              fontSize: 25,
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
                        'Android Mobile',
                        style: TextStyle(fontFamily: 'genuine', fontSize: 14),
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
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_location),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '123, Tanke road, ilorin, kwara State',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blueGrey),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: primaryGreen,
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    width: 70,
                    child: Icon(Icons.favorite_border, color: Colors.white,),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 60,
                      child: Text(
                        'Interested',
                        style: TextStyle(
                            fontFamily: 'genuine',
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
        )
      ],
    ));
  }
}
