import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/config file.dart';
import 'package:trainapp/filter/conditionFilter.dart';
import 'package:trainapp/filter/itemNameFilter.dart';
import 'package:trainapp/filter/locationFilter.dart';
//import 'package:trainapp/dropdown.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        leading: GestureDetector(
          onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios,)
        ),
        title: Text('Search Filter'),

      ),
      backgroundColor: Colors.blueGrey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 25, left: 30, right: 30),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ItemName()),
            Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LocationFilter()),
            Container(
              margin: EdgeInsets.only(top: 20, left: 30, right: 30),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ProductCondition(),
            ),
            Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 30, right: 30),
                    padding: EdgeInsets.all(2),
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: ' -N- ',
                        border: InputBorder.none,
                        labelText: "Min Price",
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 10, right: 30),
                    padding: EdgeInsets.all(1),
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixText: ' -N- ',
                          border: InputBorder.none,
                          labelText: "Max Price"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
              child: Text(
                'Apply Filter',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'genuine', fontSize: 20),
              ),
              decoration: BoxDecoration(
                  color: primaryGreen, borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ),
      ),
    );
  }
}
