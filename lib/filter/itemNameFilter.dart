import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/model/modelData.dart';

import '../config file.dart';

class ItemName extends StatefulWidget {
  @override
  _ItemNameState createState() => _ItemNameState();
}

class _ItemNameState extends State<ItemName> {
  
  Products products = Products();
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              hint: Text('Item', style: TextStyle(fontSize: 19)),
              value: mySelection,
              onChanged: (String newValue){
                
                  mySelection=newValue;
                  products.productName = mySelection;
               
                print(products.productName);
              },
              items: myJson.map((Map map){
                return DropdownMenuItem<String>(
                    value: map["product"].toString(),
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.laptop),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(map["product"]),
                        ),
                      ],
                    ));
              }).toList(),
            ),
          ),
        ))
      ],
    );
  }
}
