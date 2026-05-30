class product {
  late String id;
  late String productName;
  late String productCode;
  late String image;
  late String unitPrice;
  late String quentity;
  late String totalPrice;

  product();

  product.formJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    productName = json['ProductName'] ?? '';
    productCode = json['ProductCode'] ?? '';
    image = json['Img'] ?? '';
    unitPrice = json['UnitPrice'] ?? '';
    quentity = json['Qty'] ?? '';
    totalPrice = json['TotalPrice'] ?? '';
  }
}
