class Products{
  String productName;
  String productPrice;
  String location;
  String picture;

  Products(this.productName, this.productPrice, this.location, this.picture);
}

List <Products> productList= [
  Products('Kettle', '289500.0',"iyana alfa",'images/phone.jpg'),
  Products('Iron', '2500.0',"Tanke",'images/shirt.jpg'),
  Products('Car', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products('house', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products('House', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products('Phone', '289500.0',"iyana alfa",'images/shirt.jpg'),
  Products('Phone', '289500.0',"iyana alfa",'images/shirt.jpg'),
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