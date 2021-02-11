class Products{
  String sellerId;
  String productName;
  String productPrice;
   String type;
  String productDescription;
  String location;
  bool negotiable;
  String picture;

  Products();
}

class Products1{
  String productName;
  String productPrice;
   //String type;
  //String productDescription;
  String location;
  //bool negotiable;
  String picture;

  Products1(this.productName, this.productPrice,this.location,this.picture);
}

List <Products1> productList= [
  Products1('Kettle', '289500.0',"iyana alfa",'images/phone.jpg'),
  Products1('Iron', '2500.0',"Tanke",'images/shirt.jpg'),
  Products1('Car', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products1('house', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products1('House', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products1('Phone', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products1('Phone', '289500.0',"iyana alfa",'images/shirt.jpg'),
];

class MenuDetails{
  String icon;
  String iconTag;

  MenuDetails(this.icon, this.iconTag);
}

class ViewProduct{
  final int productId;
  final String name;
  final String description;

  ViewProduct(this.productId, this.name, this.description);
}

