import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/model/messageModel.dart';

import 'Chats.dart';

class MessageUi extends StatefulWidget {
  @override
  _MessageUiState createState() => _MessageUiState();
}

class _MessageUiState extends State<MessageUi> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isMinimized = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        decoration: BoxDecoration(
          color: primaryGreen.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(isMinimized ? 18 : 0)),
        ),
        duration: Duration(milliseconds: 250),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isMinimized
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
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
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            isMinimized = true;
                            xOffset = 200;
                            yOffset = 120;
                            scaleFactor = 0.7;
                          });
                        },
                      ),
                Text('My Messages'),
                IconButton(
                  icon: Icon(FontAwesomeIcons.userAlt),
                  onPressed: () {},
                )
              ],
            ),
            Expanded(
                child: Container(
              color: Colors.white.withOpacity(0.5),
              child: StreamBuilder(
                stream: Firestore.instance.collection('messages').snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return !snapshot.hasData 
                  ? Center(
                    child: Column(
                      children: [
                        IconButton(icon:Icon(Icons.hourglass_empty), onPressed: null,),
                        Text('No Message', 
                        style: TextStyle(fontSize: 20, color: Colors.grey),)
                      ],
                    ),
                  ): 
                  ListView.builder(
                      itemCount: snapshot.data.documents.length,//chatList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        final chat = snapshot.data.documents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_)=> Chats(
                                          user: chat['sender'],
                                          reciever:chat['reciever'],
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color:
                                  chat['status'] == 'read' ? Colors.white : Color(0xFFFFEFEE),
                            ),
                            margin: EdgeInsets.only(
                                left: 5.0, right: 20.0, bottom: 5.0, top: 5.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                          'images/shirt.jpg'
                                          ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          chat['sender'],
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(chat['message'])
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(chat['time']),
                                    chat['status'] == 'read'
                                        ? Text('')
                                        : Container(
                                            height: 20,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                              color: Colors.redAccent,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('New'),
                                          )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
