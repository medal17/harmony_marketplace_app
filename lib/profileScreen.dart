import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';
import 'package:trainapp/profileForm.dart';

//import 'model/userModel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int edit = 0;
  
  /*final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();*/

  String name ='';
  String number;
  String password;
  String address;

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    Stream shot = Firestore.instance.collection('users').document(authNotifier.user.uid.toString()).snapshots();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('My Profile'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (edit == 0) {
                    setState(() {
                      edit = 1;
                    });
                  } else {
                    setState(() {
                      edit = 0;
                    });
                  }
                }),
            Text(
              'Edit',
              textAlign: TextAlign.center,
            ),
          ],
          backgroundColor: Colors.blueGrey.withOpacity(0.02),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:  StreamBuilder(
                stream: shot,
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                                  return Text('loading');
                                }
                                var userDocument = snapshot.data;
                                name = userDocument['Name'];
                                number = userDocument['Phone'];
                                address = userDocument['Location'];
                                password = userDocument['Password'];
                  return Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Container(
                            color: Colors.blueGrey.withOpacity(0.4),
                                child : Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 25),
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        //color: primaryGreen,
                                      ),
                                      child: ClipOval(
                                        child: authNotifier.user.photoUrl !=null ? CachedNetworkImage(
                                      
                                          height: 120,
                                          width: 120, 
                                          imageUrl:authNotifier.user.photoUrl,
                                        ) : Icon(Icons.account_circle, size: 120,color: primaryGreen,)
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        userDocument['Name'],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'genuine',
                                            fontWeight: FontWeight.w200,
                                            color: primaryGreen),
                                      ),
                                    ),
                                    /*Text(userDocument['Phone'],
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800)),*/
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 15),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blueGrey.withOpacity(0.1)),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.location_on),
                                          Text(
                                            userDocument['Location'],
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(' Kwara State.',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                          ),

                          /*Container(
                            margin: EdgeInsets.symmetric(horizontal: 40),
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
                                      Text('Products'),
                                    ],
                                  ),
                                ),
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
                                      Text('Available'),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 26),
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
                          ),*/
                          /*Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey.withOpacity(0.1)),
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            margin:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Joined Since",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey[700]),
                                ), SizedBox(width:5),
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
                          ),*/


                          SizedBox(height:10),



                          edit==1?Container(height:30,width:200, color:Colors.red,child: ProfileForm('Email', userDocument['Email'],shot))
                          :
                          Container(
                            //width:MediaQuery.of(context).size.width*0.9,
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueGrey.withOpacity(0.1)),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  margin:
                                      EdgeInsets.only(left: 30, right: 5, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'genuine',
                                            fontWeight: FontWeight.w200,
                                            color: Colors.blueGrey[700]),
                                      ),
                                      Text(
                                        userDocument['Email'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'genuine',
                                            fontWeight: FontWeight.w200,
                                            color: primaryGreen),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  color:Colors.orangeAccent,
                                  onPressed: (){
                                      setState(() {
                                        edit = 1;
                                      });
                                      
                                  },)
                              ],
                            ),
                          ),

                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey.withOpacity(0.1)),
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            margin:
                                EdgeInsets.only(left: 30, right: 30, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey[700]),
                                ),
                                Text(
                                  userDocument['Phone'],
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            margin:
                                EdgeInsets.only(left: 30, right: 30, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Username",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey[700]),
                                ),
                                Text(
                                  userDocument['Name'],
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            margin:
                                EdgeInsets.only(left: 30, right: 30, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'genuine',
                                      fontWeight: FontWeight.w200,
                                      color: Colors.blueGrey[700]),
                                ),
                                Text(
                                  userDocument['Password'],
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            margin:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 0),
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
                                Row(
                                  children: [
                                    Text(
                                      "Sold",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'genuine',
                                          fontWeight: FontWeight.w200,
                                          color: Colors.blueGrey[700]),
                                    ),
                                    SizedBox(width:40),
                                      Text(
                                      "(60)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'genuine',
                                          fontWeight: FontWeight.w200,
                                          color: Colors.blueGrey[700]),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 2),
                                      width:
                                          MediaQuery.of(context).size.width * 0.60,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      "50%",
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
                                Row(
                                  children: [
                                    Text(
                                      "Available",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'genuine',
                                          fontWeight: FontWeight.w200,
                                          color: Colors.blueGrey[700]),
                                    ),
                                    SizedBox(width:40),
                                      Text(
                                      "(50)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'genuine',
                                          fontWeight: FontWeight.w200,
                                          color: Colors.blueGrey[700]),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(right: 2),
                                      width:
                                          MediaQuery.of(context).size.width * 0.60,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      "50%",
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
                        ]));
                }
              )
               
        ));
  }
}
