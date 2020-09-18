import 'package:flutter/material.dart';
class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          Image(image: AssetImage("assets/images/icons/handeezLogo.png"),),
          Text("Handeez",
            style: TextStyle(
                fontFamily: "italianno",
                fontSize: 32
            ),)
        ],
      ),
    );
  }
}