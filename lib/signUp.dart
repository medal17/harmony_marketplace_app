//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/api/Firebase_Api.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/logInScreen.dart';

import 'model/userModel.dart';
import 'notifier/Auth_Notifier.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  
 
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
   //final TextEditingController _passwordController = TextEditingController();
  LocalUser _user = LocalUser();

  @override
  void initState() {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen:false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  
  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen:false);
    signup(_user, authNotifier);

  }
  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
        body: 
        Form(
            key: _formKey,
            autovalidate: true,
            child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blueGrey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 13),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: 'genuine',
                          fontWeight: FontWeight.w200,
                          fontSize: 25,
                          color: primaryGreen),
                    ),
                  ),
                  //Text(notice != "" ? notice : ""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: primaryGreen,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        height: 47,
                        width: 50,
                        child: Icon(
                          Icons.contact_mail,
                          size: 17,
                          color: Colors.white70,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child:TextFormField(
                            //controller: name,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                hintText: 'Full name',
                                border: InputBorder.none
                            ),
                            validator: (String value){
                              if(value.isEmpty || value.length < 5){
                                return 'Input your Name';
                              }
                              return null;
                            },
                            
                          ),
                        ),
                      )
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 47,
                          width: 50,
                          child: Icon(
                            Icons.alternate_email,
                            size: 18,
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              //controller: email,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              validator: (String value){
                                if(value.isEmpty || value.length<14){
                                  return 'input a valid email';
                                }
                                return null;
                              },
                              onSaved: (String value){
                                _user.email = value;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 47,
                          width: 50,
                          child: Icon(
                            FontAwesomeIcons.phoneAlt,
                            size: 17,
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextField(
                              //controller: phone,
                              decoration: InputDecoration(
                                hintText: 'Phone',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 47,
                          width: 50,
                          child: Icon(
                            FontAwesomeIcons.user,
                            size: 17,
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              //controller: username,
                              //obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Username',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              validator: (String value){
                                if(value.isEmpty){
                                  return 'please set a username';
                                }
                                return null;
                              },
                              onSaved: (String value){
                                _user.userName = value;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              color: primaryGreen,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          height: 47,
                          width: 50,
                          child: Icon(
                            FontAwesomeIcons.key,
                            size: 17,
                            color: Colors.white70,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              //controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              validator: (String value){
                                if(value.isEmpty || value.length <6){
                                  return 'value must be atleast characters';
                                }
                                return null;
                              },
                              onSaved: (String value){
                                _user.password = value;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  GestureDetector(
                    
                    onTap: (){ 
                           
                       _submitForm();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 90),
                      child: Text(
                        'sign up',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'genuine', fontSize: 20),
                      ),  
                      decoration: BoxDecoration(
                          color: primaryGreen, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LogInScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                      child: Text(
                        'log in',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'genuine', fontSize: 20),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.black, borderRadius: BorderRadius.circular(10)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
