import 'package:flutter/material.dart';
import 'package:trainapp/config%20file.dart';

class LocationFilter extends StatefulWidget {
  @override
  _LocationFilterState createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
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
              hint: Text('Location', style: TextStyle(fontSize: 19)),
              value: locationSelected,
              onChanged: (String newValue1){
                setState((){
                  locationSelected=newValue1;
                });
                print(locationSelected);
              },
              items: place.map((Map map1){
                return DropdownMenuItem<String>(
                    value: map1["local"].toString(),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(map1["local"]),
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
