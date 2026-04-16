class Product {
  String name;
  double price;

  Product(this.name, this.price);
  Product.free(this.name) : price = 0;

  void showInfo() {
    print("Product: $name, Price: $price");
  }
}

void main() {
  var obj1 = Product("Apple", 200);
  var obj2 = Product.free("Gift");

  obj1.showInfo();
  obj2.showInfo();
}
