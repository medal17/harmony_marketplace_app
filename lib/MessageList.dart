import 'dart:ui';
import 'package:async/async.dart' show StreamGroup;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/config%20file.dart';
// import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'Chats.dart';

class MessageUi extends StatefulWidget {
  @override
  _MessageUiState createState() => _MessageUiState();
}

class _MessageUiState extends State<MessageUi> {
  void getData() async {
    //use a Async-await function to get the data
    final data = await Firestore.instance
        .collection("messages")
        .document('iyandaadeshina@gmail.com')
        .get(); //get the data
    // snapshot = data;
    // print(data.data);
  }

  Stream myMessages = Firestore.instance
      .collection('messages')
      .where('sender', isEqualTo: 'iyandaadeshina@gmail.com')
      .snapshots();
  Stream recievedMessages = Firestore.instance
      .collection('messages')
      .where('reciever', isEqualTo: 'iyandaadeshina@gmail.com')
      .snapshots();

  // Observable.merge([stream1, stream2]).pipe(combineStream);
  var messages;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isMinimized = false;
  List<DocumentSnapshot> msgs = new List<DocumentSnapshot>();

  @override
  Widget build(BuildContext context) {
    getData();
    var message;
    // allMessages = myMessages.expand((element) => element);
    messages = CombineLatestStream(
        [recievedMessages, myMessages], (values) => values.last);
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
            Container(
              alignment: Alignment.bottomCenter,
              height: 70,
              child: Row(
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
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              isMinimized = true;
                              xOffset = 200;
                              yOffset = 120;
                              scaleFactor = 0.7;
                            });
                            Navigator.pop(context);
                          },
                        ),
                  Text('My Messages'),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.userAlt),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.white.withOpacity(0.5),
              child: StreamBuilder(
                stream: myMessages,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List<DocumentSnapshot> people1 = new List<DocumentSnapshot>();
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    msgs.add(snapshot.data.documents[i]);
                    print(msgs.length);
                  }
                  return !snapshot.hasData
                      ? Center(
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.hourglass_empty),
                                onPressed: null,
                              ),
                              Text(
                                'No Message',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      : StreamBuilder(
                          stream: recievedMessages,
                          builder: (context, snapshot1) {
                            // final reducedList = [];

                            //   list.reduce((value, element) {
                            //       if (value != element)
                            //           reducedList.add(value);
                            //       return element;
                            //   });

                            //   reducedList.add(list.last);
                            List<DocumentSnapshot> people =
                                new List<DocumentSnapshot>();
                            for (int i = 0;
                                i < snapshot1.data.documents.length;
                                i++) {
                              msgs.add(snapshot1.data.documents[i]);
                              // print(msgs[0]['sender']);
                            }
                            // messages.add(people);
                            // messages.add(people1)
                            return ListView.builder(
                                itemCount: snapshot1.data.documents.length +
                                    snapshot.data.documents
                                        .length, //chatList.length,
                                itemBuilder: (BuildContext ctx, int index) {
                                  final chat = msgs[index];

                                  // print(chats);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Chats(
                                                    user: chat['sender'],
                                                    reciever: chat['reciever'],
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: chat['status'] == 'read'
                                            ? Colors.white
                                            : primaryGreen.withOpacity(0.07),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: 5.0,
                                          right: 20.0,
                                          bottom: 5.0,
                                          top: 5.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 35.0,
                                                backgroundImage: AssetImage(
                                                    'images/shirt.jpg'),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(chat['time'].toString()),
                                              chat['status'] == 'read'
                                                  ? Text('')
                                                  : Container(
                                                      height: 20,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
                                                        ),
                                                        color: Colors.redAccent
                                                            .withOpacity(0.3),
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text('New'),
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
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
