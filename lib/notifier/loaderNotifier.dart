import 'package:flutter/cupertino.dart';

class LoaderNotifier with ChangeNotifier {
  bool creatingProduct = false;

  void setProductLoader(bool val) {
    // print(user.uid.toString());
    creatingProduct = val;
    notifyListeners();
  }
}
