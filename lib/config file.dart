import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainapp/profileScreen.dart';
import 'package:trainapp/sellProduct.dart';
import 'package:trainapp/wishList.dart';

import 'MessageList.dart';

Color primaryGreen = Color(0xff004240);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];
List<BoxShadow> shadowListBlack = [
  BoxShadow(color: Colors.black54, blurRadius: 30, offset: Offset(0, 10))
];

List<Icon> categories = [
  Icon(
    Icons.home,
    color: Colors.blueGrey[300],
    size: 29,
  ),
  Icon(Icons.computer, color: Colors.blueGrey[500], size: 29),
  Icon(FontAwesomeIcons.cottonBureau, color: Colors.blueGrey[500], size: 29),
  Icon(FontAwesomeIcons.cookieBite, color: Colors.blueGrey[500], size: 29),
  Icon(FontAwesomeIcons.building, color: Colors.blueGrey[500], size: 29),
  Icon(FontAwesomeIcons.car, color: Colors.blueGrey[500], size: 29),
  
];

List<String> menuTag = [
  'All',
  'Computers',
  'Fashion',
  'Food Items',
  'Housing',
  'Rides',
];

List<Map> drawerMenu = [
  {'icon': FontAwesomeIcons.hamburger, 'title': 'My Products'},
  {'icon': FontAwesomeIcons.shoppingCart, 'title': 'Sell Product'},
  /*{
    'icon' : FontAwesomeIcons.plusCircle,
    'title' : 'Add Product'
  },*/
  {'icon': Icons.favorite, 'title': 'Wish List'},
  {'icon': Icons.email, 'title': 'Messages'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'}
];

String mySelection;
List<Map> myJson = [
  {"id": 1, "image": "assets/", "product": "Phone"},
  {"id": 2, "image": "assets/", "product": "Laptop"},
  {"id": 3, "image": "assets/", "product": "Cloth"},
  {"id": 4, "image": "assets/", "product": "Food"},
  {"id": 5, "image": "assets/", "product": "Accessories"},
  {"id": 6, "image": "assets/", "product": "Make up"},
  {"id": 7, "image": "assets/", "product": "Kitchen"},
];

String locationSelected;
List<Map> place = [
  {"id": 1, "state": "Lagos", "local": "Ikorodu"},
  {"id": 2, "state": "Lagos", "local": "Ikeja"},
  {"id": 3, "state": "Lagos", "local": "Ojota"},
  {"id": 4, "state": "Lagos", "local": "Ketu"},
  {"id": 5, "state": "Lagos", "local": "V.Island"}
];

String productCondition;
List<Map> conditionList = [
  {
    "id": 1,
    "condition": "Fairly Used",
  },
  {
    "id": 2,
    "condition": "New",
  },
  {
    "id": 3,
    "condition": "Uk used",
  },
];

navigate(BuildContext context, String link) {
  switch (link) {
    case "Profile":
      Navigator.push(context, MaterialPageRoute(builder: (_) => Profile()));
      break;
    case "Sell Product":
      Navigator.push(context, MaterialPageRoute(builder: (_) => SellProduct()));
      break;
    case "Messages":
      Navigator.push(context, MaterialPageRoute(builder: (_) => MessageUi()));
      break;
    case "Wish List":
      Navigator.push(context, MaterialPageRoute(builder: (_) => WishList()));
      break;

  }
}
