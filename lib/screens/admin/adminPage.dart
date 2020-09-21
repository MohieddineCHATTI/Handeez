import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/screens/admin/Orders.dart';
import 'package:handeez/screens/admin/addProduct.dart';
import 'package:handeez/screens/admin/manageProducts.dart';

class AdminPage extends StatelessWidget {
  static String id = "adminPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          RaisedButton(child: Text("Add Product"),onPressed: (){
            Navigator.pushNamed(context, AddProduct.id);
          },),
          RaisedButton(child: Text("Edit Product"),onPressed: (){
            Navigator.pushNamed(context, ManageProducts.id);
          },),
          RaisedButton(child: Text("View Orders"),onPressed: (){
            Navigator.pushNamed(context, Orders.id);
          },),
        ],
      ),
    );
  }
}
