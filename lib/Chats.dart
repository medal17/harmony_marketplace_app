import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:trainapp/model/messageModel.dart';
import 'package:trainapp/notifier/Auth_Notifier.dart';

import 'config file.dart';
//import 'model/userModel.dart';

class Chats extends StatefulWidget {
  final String user;
  final String reciever;
  Chats({this.user, this.reciever});
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  /*_typeMessage() {
   Container(
     margin: EdgeInsets.all(15.0),
     height: 61,
     child: Row(
       children: <Widget>[
         Expanded(
           child: Container(
             decoration:BoxDecoration(
                 borderRadius: BorderRadius.circular(35),
             color: Colors.grey,
             boxShadow: shadowList),
             child: Row(
               children: <Widget>[
                 IconButton(icon: Icon(Icons.face), onPressed: () {},),
                 Expanded(
                     child: TextField(
                       decoration: InputDecoration(
                         hintText: "type something",
                         border: InputBorder.none
                       ),
                     )),
                 IconButton(icon: Icon(Icons.camera_alt), onPressed: () {},),
                 IconButton(icon: Icon(Icons.attach_file), onPressed: () {},),
               ],
             ),
           ),
         ),
         SizedBox(width: 15,),
         Container(
           padding: EdgeInsets.all(15),
           decoration: BoxDecoration(
             color: primaryGreen,
             shape: BoxShape.circle
           ),
           child: InkWell(
             child: Icon(Icons.keyboard_voice,
             color: Colors.white
               ,),
           ),
         )
       ],
     ),
   );
  }
*/
  loadMessage(DocumentSnapshot message, bool isMe) {
    final Container myMessage = Container(
      decoration: isMe
          ? BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10)),
              color: primaryGreen)
          : BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)),
              color: Colors.grey.withOpacity(0.6)),
      margin: isMe
          ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
      //width: MediaQuery.of(context).size.width * 0.75,
      child: Text(
        message['message'] != null ? message['message'] : '',
        style: TextStyle(
            color: isMe ? Colors.white : primaryGreen,
            fontWeight: FontWeight.w200,
            fontSize: 14.0,
            fontFamily: 'genuine'),
      ),
    );

    if (isMe) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            message['time'] != null ? message['time'] : '',
          ),
          myMessage,
        ],
      );
    }
    return Container(
      //margin: EdgeInsets.only(right: 45),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          myMessage,
          Text(
            message['time'] != null ? message['time'] : '',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white.withOpacity(0.5),
              child: ClipRRect(
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .where('reciever', isEqualTo: authNotifier.user.email)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              final message = snapshot.data.documents[index];
                              // print(message);
                              // authNotifier.user.email
                              final bool isMe =
                                  message['sender'] == authNotifier.user.email;
                              //     ||
                              // message['reciever'] ==
                              //     authNotifier.user.email;
                              //final chat= messages[index]; //message.sender.id == me.id || message.reciever.id == me.id ?;
                              return loadMessage(message, isMe);
                            })
                        : Column(
                            children: [
                              IconButton(
                                onPressed: null,
                                icon: Icon(Icons.hourglass_empty),
                              ),
                              Text('No Messages'),
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.withOpacity(0.3),
                        boxShadow: shadowList),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 18,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                            child: TextField(
                          decoration: InputDecoration(
                              hintText: "Type something",
                              border: InputBorder.none),
                        )),
                        //IconButton(icon: Icon(Icons.camera_alt), onPressed: () {},),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 48,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

      /*GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    child: StreamBuilder(

                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            // reverse: true,

                            itemCount: messages.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Message message = messages[index];
                              final bool isMe = message.sender.id == me.id;
                              return ;
                                //loadMessage(message, isMe);
                            });
                      }
                    ),
                  ),
                ),
              ),
             // _typeMessage(),
            ],
          ),
        )*/
    );
  }
}
