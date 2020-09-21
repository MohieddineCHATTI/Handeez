import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';


class AboutUS extends StatelessWidget {
  static String id = "aboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
          backgroundColor: mainColor,
        ),
    body: Container(child: Center(child: Text("About Us Screen\n to be filled later"),),),);
  }
}
