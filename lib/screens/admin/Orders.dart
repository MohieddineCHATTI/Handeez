import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/order.dart';
import 'package:handeez/screens/admin/orderDetails.dart';
import 'package:handeez/services/store.dart';

class Orders extends StatelessWidget {
  static String id = "orders";
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("There are no orders"),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.docs) {
              orders.add(Order(
                  docId: doc.id,
                  totalPrice: doc.data()[totalPrice],
                  address: doc.data()[clientAddress]));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, OrderDetails.id, arguments: orders[index].docId);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: mainColor,
                      child: Card(
                        elevation: 2,
                        color: secondaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Order Number : ${index+1}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Divider(thickness: 2,color: mainColor,),
                              Text("Total Price : ${orders[index].totalPrice}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Client Address : ${orders[index].address}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Client Number : 000-000-000-000",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
