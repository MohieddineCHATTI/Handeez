import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/provider/cartItems.dart';
import 'package:handeez/screens/user/cart.dart';
import 'package:provider/provider.dart';
import 'package:handeez/functions/addProductToCart.dart';
class ProductInfo extends StatefulWidget {
  static String id = "productInfo";
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int quantity = 1;
  final PageController _imageController = PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)
        .settings
        .arguments;
    return Scaffold(
      backgroundColor: secondaryColor,
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
              child: PageView(
                  controller: _imageController,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height*.7,
                          width: MediaQuery.of(context).size.width,
                          child: product.url1 != null ? Image.network(product.url1,
                            fit: BoxFit.cover,): Image.network("http://lorempixel.com/200/500/fashion/",
                            fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height*.7,
                          width: MediaQuery.of(context).size.width,
                          child: product.url2 != null ? Image.network(product.url2,
                            fit: BoxFit.cover,): Image.network("http://lorempixel.com/200/500/fashion/",
                            fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height*.7,
                          width: MediaQuery.of(context).size.width,
                          child: product.url3 != null ? Image.network(product.url3,
                            fit: BoxFit.cover,): Image.network("http://lorempixel.com/200/500/fashion/",
                            fit: BoxFit.cover,),
                        ),
                      ),
                    ),



                  ]
              ),
          ),
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
                  Builder(
                    builder:(context) => FlatButton.icon(onPressed: (){
                      addToCart(context, product, quantity);
                    }, icon: Icon(Icons.add_shopping_cart), label: Text("Add to Cart")),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            maxChildSize: 0.4,
            builder: (BuildContext context, ScrollController scrollController){
              return Opacity(
                opacity: 0.8,
                child: Container(
                  color: Colors.white70,
                  height: MediaQuery.of(context).size.height*.5,
                  width: MediaQuery.of(context).size.width*.5,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward, color: Colors.green,size: 36,),
                              Text("Swipe Up for Product Details"),
                              Icon(Icons.arrow_upward, color: Colors.green,size: 36,),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                      )

                    )),
                ),
              );


            },
          )
//          Positioned(
//            bottom: 0,
//            child: Column(
//              children: [
//                Opacity(
//                  opacity: 0.7,
//                  child: SingleChildScrollView(
//                    child: Container(
//                      width: MediaQuery
//                          .of(context)
//                          .size
//                          .width,
//                      height: MediaQuery
//                          .of(context)
//                          .size
//                          .height * .3,
//                      color: Colors.white,
//                      child: Padding(
//                        padding: const EdgeInsets.all(20),
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            Text(
//                              product.pName,
//                              style: TextStyle(
//                                  fontSize: 20, fontWeight: FontWeight.bold),
//                            ),
//                            SizedBox(
//                              height: 10,
//                            ),
//                            Text(
//                              "\$ ${product.pPrice}",
//                              style: TextStyle(
//                                  fontSize: 22,
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.red),
//                            ),
//                            SizedBox(
//                              height: 10,
//                            ),
//                            Text(
//                              product.pDescription,
//                              style: TextStyle(
//                                  fontSize: 20, fontWeight: FontWeight.w800),
//                            ),
//                            SizedBox(
//                              height: 10,
//                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: [
//                                ClipOval(
//                                    child: Material(
//                                        color: mainColor,
//                                        child: GestureDetector(
//                                            onTap: () {
//                                              if (quantity > 1)
//                                                setState(() {
//                                                  quantity --;
//                                                });
//                                            },
//                                            child: SizedBox(
//                                              width: 20,
//                                              height: 20,
//                                              child: Icon(Icons.remove),
//                                            )))),
//                                SizedBox(width: 10,),
//                                Text(quantity.toString(), style: TextStyle(
//                                    fontSize: 30
//                                ),),
//                                SizedBox(width: 10,),
//                                ClipOval(
//                                    child: Material(
//                                        color: mainColor,
//                                        child: GestureDetector(
//                                            onTap: () {
//                                              setState(() {
//                                                quantity++;
//                                              });
//                                            },
//                                            child: SizedBox(
//                                              width: 20,
//                                              height: 20,
//                                              child: Icon(Icons.add),
//                                            )))),
//                              ],
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//                ButtonTheme(
//                  minWidth: MediaQuery
//                      .of(context)
//                      .size
//                      .width,
//                  height: MediaQuery
//                      .of(context)
//                      .size
//                      .height * 0.08,
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.only(
//                          topRight: Radius.circular(30),
//                          topLeft: Radius.circular(30))),
//                  child: Builder(
//                    builder: (context) =>
//                        RaisedButton(
//                          onPressed: () {
//                            addToCart(context, product, quantity);
//                          },
//                          color: mainColor,
//                          child: Text(
//                            "Add to cart".toUpperCase(),
//                            style:
//                            TextStyle(fontSize: 16, fontWeight: FontWeight
//                                .bold),
//                          ),
//                        ),
//                  ),
//                ),
//              ],
//            ),
//          )
        ],
      ),
    );
  }

}