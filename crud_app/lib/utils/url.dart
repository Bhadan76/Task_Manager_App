class url {
  static const String _baseUrl = 'https://crud.teamrabbil.com/api/v1';
  static const String getProductsUrl = '$_baseUrl/ReadProduct';
  static const String createProductUrl = '$_baseUrl/CreateProduct';
  static String updateProductUrl(String id) => '$_baseUrl/UpdateProduct/$id';
  static String deleteProductUrl(String id) => '$_baseUrl/DeleteProduct/$id';
}
