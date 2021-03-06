import 'package:flutter/material.dart';
//import 'package:trainapp/model/modelData.dart';
import 'package:trainapp/config file.dart';
import 'package:trainapp/model/modelData.dart';

class ProductCondition extends StatefulWidget {
  @override
  _ProductConditionState createState() => _ProductConditionState();

}

class _ProductConditionState extends State<ProductCondition> {

Products products = Products();


  @override
  Widget build(BuildContext context) {
    return Container(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isDense: true,
                  hint: Text('Condition', style: TextStyle(fontSize: 19),),
                  value: productCondition,
                  onChanged: (String newCategory){
                    
                      productCondition=newCategory;
                      products.type = productCondition;
                      
                   
                    print(products.type);
                    //return products.type;
                  },
                  items: conditionList.map((Map conditionMap){
                    return DropdownMenuItem<String>(
                        value: conditionMap["condition"].toString(),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(conditionMap["condition"]),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
              ),
            ))
          ],
        )
    );
  }
}
