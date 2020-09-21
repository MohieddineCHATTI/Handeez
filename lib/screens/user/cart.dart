import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handeez/components/customMenu.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/provider/cartItems.dart';
import 'package:handeez/screens/user/productInfo.dart';
import 'package:handeez/screens/user/updateCartItem.dart';
import 'package:handeez/services/store.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static String id = "cart";
  @override
  Widget build(BuildContext context) {
    List<Product> cartItems = Provider.of<CartItems>(context).products;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("MY Cart", style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: mainColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: (){Navigator.pop(context);},),
        centerTitle: true,
      ),
      body: Column(
        children: [
          LayoutBuilder(
            builder:(context, constrains) {
              if(cartItems.isNotEmpty){
                cartItems = [...cartItems.reversed.toList()];
                return Container(
                  height: screenHeight - screenHeight*.08 - appBarHeight - statusBarHeight,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, UpdateCartItem.id, arguments: cartItems[index]);
                        },
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * .10,
                          color: secondaryColor,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: screenHeight * .10 / 2,
                                backgroundImage: AssetImage(
                                    "assets/images/${cartItems[index]
                                        .pLocation}.jpg"),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(cartItems[index].pName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          SizedBox(height: 10,),
                                          Text("\$ ${cartItems[index].pPrice}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        cartItems[index].quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    )
                                  ],
                                ),
                              ),
                              IconButton(icon:Icon(Icons.delete), color: Colors.red,onPressed: (){
                                Provider.of<CartItems>(context, listen: false).deleteProduct(cartItems[index]);
                              },)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                    itemCount: cartItems.length,),
                );
              } else {
                return Container(
                  height: screenHeight - screenHeight*.08- appBarHeight - statusBarHeight,
                  child: Center(child: Text("Cart Empty", style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),)),
                );
              }

            }),
          cartItems.isNotEmpty ? Builder(
            builder: (context) => ButtonTheme(
              minWidth: screenWidth,
              height: screenHeight*.08,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                  )
                ),
                child: Text("order".toUpperCase(),style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),) ,
                onPressed: (){
                  showCustomDialog(context, cartItems);
                },
                color: mainColor,),
            ),
          ) : Text("Please add products to cart first")
        ],
      ),
    );
  }

  void showCustomDialog(context, List<Product> cartItems) async{
    var price = getTotalPrice(cartItems);
    var address ;
    AlertDialog alertDialog = AlertDialog(
      title: Text("total Price : \$ $price"),
      content: TextField(
        onChanged: (value){
          address = value;
        },
        decoration: InputDecoration(
        hintText: "Enter Your Address",
      ),
      ),
      actions: [
       MaterialButton(child: Text("confirm"),onPressed: (){
           try{
             Store _store = Store();
             _store.storeOrders({
               totalPrice: price,
               clientAddress: address
             }, cartItems);
             Scaffold.of(context).showSnackBar(SnackBar(
               content: Text("Ordered successfully"),
             ));
             Navigator.pop(context);
           }catch (ex) {print(ex.toString());}

         },),
      ],
    );
    await showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  getTotalPrice(List<Product> cartItems) {
    var price = 0;
    for (var product in cartItems){
      price += product.quantity*int.parse(product.pPrice);
    }
    return price;
  }
}
