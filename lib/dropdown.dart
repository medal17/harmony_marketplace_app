import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dropdown{
  List<String> options;
  List<Icon> icon;
  String mySelection;

  Dropdown(this.options,this.icon, this.mySelection);
}
showOptions(  String selection, List<Map> api){
  Container(
    margin: EdgeInsets.only(top: 35,left: 30,right: 30),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        width: 1,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              isDense: true,
              hint: Text('Item'),
              value: selection,
              onChanged: (String newValue){
                 selection=newValue;

                print(selection);
              },
              items: api.map((Map map){
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
    ),
  );
}
