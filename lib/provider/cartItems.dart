import 'package:flutter/cupertino.dart';
import 'package:handeez/modals/product.dart';

class CartItems extends ChangeNotifier{

  List <Product> products = [];

  addProductToCart(Product product){
    products.add(product);
    notifyListeners();
  }
  deleteProduct (Product product){
    products.remove(product);
    notifyListeners();
  }
}