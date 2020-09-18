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
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width,
                      color: secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Total Price = ${orders[index].totalPrice}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Client Address = ${orders[index].address}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
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
