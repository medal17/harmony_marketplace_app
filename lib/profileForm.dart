import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'notifier/Auth_Notifier.dart';
//import 'package:trainapp/model/userModel.dart';

class ProfileForm extends StatelessWidget {
  final String title;
  final initialValue;
  final shot;
  ProfileForm(this.title, this.initialValue, this.shot);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _submitForm(){
    if(!_formKey.currentState.validate()){
      return;
    }
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    //var newUser = NewUser();
    return Row(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top:10, left: 35),
                child: Text(title,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13,
                      fontFamily: 'genuine',
                      fontWeight: FontWeight.w200,
                       
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.065,
                margin: EdgeInsets.only( left: 30, right: 30),
                padding: EdgeInsets.only(bottom: 10, left: 7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  initialValue: initialValue,
                  decoration: InputDecoration(
                    //labelText: 'hi',
                    border: InputBorder.none,
                  ),
                  onChanged: (String value){
                    print(value);
                      /*switch(title){
                        case "name": newUser.name = value;
                        break;
                        case "email": newUser.email = value;
                        break;
                        case "Phone number": newUser.phone = value;
                        break;
                        case "Password": newUser.password = value;
                        break;
                        case "Address": newUser.location = value;
                        break;
                      }*/


                  },
                  //controller: controller,
                  onSaved: (String value) {
                    //product.productName = value;
                    Firestore.instance.collection('users').document(authNotifier.user.uid).setData({'$title':'value'});
                    
                     print(value);
                  },                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '$title Cannot bxe empty';
                      
                    }

                    if (value==initialValue) {
                      return 'Nothing has changed';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),

        Container(child: IconButton(icon: Icon(Icons.check), onPressed: (){       
          _submitForm();
        }),)
      ],
    );
  }
}
