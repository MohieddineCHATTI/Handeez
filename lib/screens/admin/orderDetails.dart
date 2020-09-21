import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id = "orderDetails";
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrderDetails(docId),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<Product> products = [] ;
            for (var doc in snapshot.data.docs){
              products.add(Product(
                pName: doc.data()[pName],
                quantity: doc.data()[quantity],
                pCategory: doc.data()[pCategory],
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width,
                        color: mainColor,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Product Name = ${products[index].pName}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Quantity = ${products[index].quantity}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Category = ${products[index].pCategory}",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonTheme(
                        buttonColor: Colors.green,
                        child: RaisedButton(
                          onPressed: (){},
                          child: Text("Confirm Order"
                          ),
                        ),
                      ),
                      ButtonTheme(
                        buttonColor: Colors.red,
                        child: RaisedButton(
                          onPressed: (){},
                          child: Text("Delete Order"
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            );
          }else{
            return Center(child: Text("Loading order details"));
          }

        },
      ),
    );
  }
}
