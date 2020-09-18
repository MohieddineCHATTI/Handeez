import 'package:handeez/modals/product.dart';
List<Product> getProductByCategory(String category, List _products) {
  List<Product> products = [];
  for (var product in _products){
    if (product.pCategory == category){
      products.add(product);
    }
  }
  return products;
}