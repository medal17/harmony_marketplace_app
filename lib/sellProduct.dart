import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/config file.dart';
//import 'package:trainapp/filter/conditionFilter.dart';
//import 'package:trainapp/filter/itemNameFilter.dart';
//import 'package:trainapp/filter/locationFilter.dart';
import 'package:trainapp/api/Firebase_Api.dart';
import 'package:trainapp/notifier/loaderNotifier.dart';

import 'model/modelData.dart';
import 'model/userModel.dart';
import 'notifier/Auth_Notifier.dart';
//import 'package:trainapp/dropdown.dart';

class SellProduct extends StatefulWidget {
  @override
  _SellProductState createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool loading = false;
  Products product = Products();
  File _image;
  String _uploadedFileURL;
  LocalUser user = LocalUser();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  //String type = mySelection;
  //String condition = productCondition;
  bool negotiable = true;
  //String location = locationSelected;

  void submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    createProduct(user, product);
  }

  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    // LoaderNotifier loaderNotifier = Provider.of<LoaderNotifier>(context);
    //condition = product.type;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryGreen,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
              )),
          title: Text(
            'Sell A Product',
            style: TextStyle(fontSize: 16),
          ),
        ),
        backgroundColor: Colors.blueGrey[50],
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Item Title', border: InputBorder.none),
                      controller: title,
                      onSaved: (String value) {
                        product.productName = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Add product title';
                        }
                        if (value.length < 5) {
                          return 'Username must be between 5 and 12';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isDense: true,
                                hint: Text('Item',
                                    style: TextStyle(fontSize: 15)),
                                value: mySelection,
                                onChanged: (String newValue) {
                                  setState(() {
                                    mySelection = newValue;
                                    product.type = mySelection;
                                  });

                                  //type = mySelection;

                                  //print(products.productName);
                                },
                                items: myJson.map((Map map) {
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
                      )),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                isDense: true,
                                hint: Text('Location',
                                    style: TextStyle(fontSize: 15)),
                                value: locationSelected,
                                onChanged: (String newValue1) {
                                  setState(() {
                                    locationSelected = newValue1;
                                    product.location = locationSelected;
                                  });
                                },
                                items: place.map((Map map1) {
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
                      )),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: Text(
                                'Condition',
                                style: TextStyle(fontSize: 15),
                              ),
                              value: productCondition,
                              onChanged: (String newCategory) {
                                setState(() {
                                  productCondition = newCategory;
                                  product.type = productCondition;
                                });

                                //condition = productCondition;
                              },
                              items: conditionList.map((Map conditionMap) {
                                return DropdownMenuItem<String>(
                                    value: conditionMap["condition"].toString(),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child:
                                              Text(conditionMap["condition"]),
                                        ),
                                      ],
                                    ));
                              }).toList(),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                    padding: EdgeInsets.all(1),
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      border: Border.all(
                        width: 1,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: description,
                      style: TextStyle(fontSize: 15),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Item Description",
                      ),
                      onSaved: ((String value) {
                        //description = value;
                        print(description);
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                        // padding: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width * 0.50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: price,
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: ' -N- ',
                            border: InputBorder.none,
                            labelText: "Price",
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Set a price';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            product.productPrice = value;
                          },
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("negotiable?",
                                  style: TextStyle(fontSize: 14)),
                              Checkbox(
                                value: true,
                                onChanged: (bool option) {
                                  if (option) {
                                    negotiable = true;
                                  }
                                },
                              ),
                            ],
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white.withOpacity(0.5),
                            ),
                            height: 80,
                            width: 80,
                            margin:
                                EdgeInsets.only(top: 19, left: 25, right: 10),
                            child: _image == null
                                ? IconButton(
                                    icon: Icon(Icons.camera_alt),
                                    onPressed: chooseFile,
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      _image != null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  height: 80,
                                  width: 80,
                                  margin: EdgeInsets.only(top: 19),
                                  child: IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: uploadFile,
                                  )),
                            )
                          : Text('')
                    ],
                  ),
                  SizedBox(
                    height: 82.0,
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (title != null &&
                    //condition != null &&
                    //type != null &&
                    price != null &&
                    //location != null &&
                    description != null &&
                    _image != null) {
                  product.sellerId = authNotifier.user.email;
                  product.productName = title.text;
                  //product.type = condition;
                  product.productDescription = description.text;
                  product.productPrice = price.text;
                  //product.location = location;
                  product.negotiable = negotiable;
                  product.picture = _uploadedFileURL;

                  // loaderNotifier.setProductLoader(true);
                  uploadFile();
                  // createProduct(user, product);
                } else {
                  print('noooo');
                }
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: Text(
                        loading ? 'Loading...' : 'Shelf Product',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                loading ? FontWeight.w200 : FontWeight.w300,
                            fontFamily: 'genuine',
                            fontSize: 18),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: loading ? Colors.black54 : primaryGreen,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future chooseFile() async {
    final picker = await ImagePicker().getImage(source: ImageSource.gallery);

    if (picker != null) {
      setState(() {
        _image = File(picker.path);
      });
      print(File(picker.path));
    }
    print('nothing');
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Upload Successful');
    print(storageReference.getDownloadURL());
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        product.picture = _uploadedFileURL;
        createProduct(user, product);
      });
    });
  }
}
