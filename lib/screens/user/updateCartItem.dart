import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/provider/cartItems.dart';
import 'package:handeez/screens/user/cart.dart';
import 'package:provider/provider.dart';
import 'package:handeez/functions/addProductToCart.dart';
class UpdateCartItem extends StatefulWidget {
  static String id = "updateCartItem";
  @override
  _UpdateCartItemState createState() => _UpdateCartItemState();
}

class _UpdateCartItemState extends State<UpdateCartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      body: Stack(
        children: [
          //TODO need to change it to network image to get images from firebase storage
          Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Image(
                image: AssetImage("assets/images/${product.pLocation}.jpg"),
                fit: BoxFit.fill,
              )),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Opacity(
                  opacity: 0.4,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .3,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.pName,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "\$ ${product.pPrice}",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            product.pDescription,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                  child: Material(
                                      color: mainColor,
                                      child: GestureDetector(
                                          onTap: () {
                                            if (quantity > 1)
                                              setState(() {
                                                quantity --;
                                              });
                                          },
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Icon(Icons.remove),
                                          )))),
                              SizedBox(width: 10,),
                              Text(quantity.toString(), style: TextStyle(
                                  fontSize: 30
                              ),),
                              SizedBox(width: 10,),
                              ClipOval(
                                  child: Material(
                                      color: mainColor,
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              quantity++;
                                            });
                                          },
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Icon(Icons.add),
                                          )))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.08,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Builder(
                    builder: (context) =>
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Provider.of<CartItems>(context, listen: false).deleteProduct(product);
                            addToCart(context, product, quantity);
                          },
                          color: mainColor,
                          child: Text(
                            "Update Cart Item".toUpperCase(),
                            style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight
                                .bold),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}