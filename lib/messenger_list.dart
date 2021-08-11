import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trainapp/config%20file.dart';
import 'package:trainapp/messengers.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:active_ecommerce_flutter/dummy_data/messengers.dart';
// import 'package:active_ecommerce_flutter/screens/chat.dart';
// import 'package:active_ecommerce_flutter/app_config.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

import 'package:http/http.dart' as http;
import 'package:trainapp/chat.dart';

class MessengerList extends StatefulWidget {
  @override
  _MessengerListState createState() => _MessengerListState();
}

// https://aratam.com/api/v2/api-get-conversation/
// https://aratam.com/api/v2/api-get-conversation-details/{id}

class _MessengerListState extends State<MessengerList> {
  final ScrollController _scrollController = ScrollController();
  // fetchData() async {
  //   final response = await http.get(
  //     Uri.parse("${AppConfig.BASE_URL}/api-get-conversation/"),
  //     headers: {HttpHeaders.authorizationHeader: '${access_token.value}'},
  //   );
  //   return response.body;
  // print(AppConfig.BASE_URL);
  // print(response.body);
  // print(access_token.value);
  // }
  // => ["a", "b", "c", "d"]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildMessengerList(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    // fetchData();
    return AppBar(
      backgroundColor: primaryGreen,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Messages",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  SingleChildScrollView buildMessengerList() {
    return SingleChildScrollView(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: messengerList.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0.0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          print(MessengerList);

          return Padding(
            padding: const EdgeInsets.only(
                top: 4.0, bottom: 4.0, left: 16.0, right: 16.0),
            child: buildMessengerItemCard(index),
          );
        },
      ),
    );
  }

  buildMessengerItemCard(index) {
    return GestureDetector(
      onTap: () {
        // List<String> result =
        //     LinkedHashSet<String>.from(messengerList).toList();
        // print(distinctMessengerList);

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Chat(
            messenger_name: messengerList[index].name,
            messenger_image: messengerList[index].image,
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100].withOpacity(0.5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                        color: Color.fromRGBO(112, 112, 112, .3), width: 1),
                    //shape: BoxShape.rectangle,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(messengerList[index].image)),
                ),
                Container(
                  height: 50,
                  width: 230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(
                          messengerList[index].name,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13,
                              height: 1.6,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 14,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
