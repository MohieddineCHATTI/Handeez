import 'package:handeez/provider/cartItems.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

void addToCart(context, product, quantity) {
  CartItems cartItems = Provider.of<CartItems>(context, listen: false);
  product.quantity = quantity;
  bool inCart = false;
  var productsInCart = cartItems.products;
    for (var productInCart in productsInCart){
      if (productInCart == product){
        inCart = true;
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Product already added to cart"),
        ));
      }
    }
    if (!inCart){
      cartItems.addProductToCart(product);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("product added to cart"),
      ));
    }

}