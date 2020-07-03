import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainapp/config%20file.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey[100],
                  ),
                  child: Image.asset(
                    'images/phone.jpg',
                    height: 200,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Information',
                      style: TextStyle(fontFamily: 'genuine', fontSize: 18),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey.withOpacity(0.1)),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              Text(
                                'Iyana Alfa, Ilorin',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text('Kwara State.',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 15,
                          ),
                          Text('08032627773',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.blueGrey.withOpacity(0.1)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('50',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800)),
                                ),
                                Text('Products')
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.blueGrey.withOpacity(0.1)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text('50',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: primaryGreen)),
                                ),
                                Text(
                                  'Sold',
                                  style: TextStyle(color: primaryGreen),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Kola Johnson",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: primaryGreen),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: primaryGreen,
                      ),
                      onPressed: () {},
                    )),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.withOpacity(0.1)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Joined Since",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey[700]),
                  ),
                  Text(
                    "July 12, 2007",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: primaryGreen),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.withOpacity(0.1)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Account Type",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey[700]),
                  ),
                  Text(
                    "individual",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: primaryGreen),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.withOpacity(0.1)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Statistics",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey[700]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Sold",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey[700]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        width: MediaQuery.of(context).size.width * 0.63,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                        ),
                        child: Container(
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        "100%",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'genuine',
                            fontWeight: FontWeight.w200,
                            color: primaryGreen),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Available",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'genuine',
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey[700]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 2),
                        width: MediaQuery.of(context).size.width * 0.63,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                        ),
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "100%",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'genuine',
                            fontWeight: FontWeight.w200,
                            color: primaryGreen),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
