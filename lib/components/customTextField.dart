import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool obsc;
  final Function onClick;
  final initialValue;
  final inputType;
  CustomTextField({@required this.icon, @required this.hint , this.obsc, @required this.onClick, this.initialValue, this.inputType});
  // ignore: missing_return
  String _errorMessage (String str){
    switch (str){
      case "Enter your email": return "Email is empty";
      case "Enter your password": return "Password is empty";
      case "Enter your name": return "Name is empty";
      case "Product Name" : return "Enter product name";
      case "Product Price" : return "Enter valid Product Price";
      case "Product Description" : return "Please enter product description ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (val) => val.isEmpty ? _errorMessage(hint): null,
        onSaved: onClick,
        initialValue: initialValue,
        cursorColor: mainColor,
        keyboardType: inputType,
        obscureText: (obsc != null && obsc == true) ? true: false,
        decoration: InputDecoration(
            filled: true,
            fillColor: secondaryColor,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                ),
                borderRadius: BorderRadius.circular(20)
            ),
            prefixIcon: Icon(icon, color: mainColor,),
            hintText: hint,
        ),
      ),
    );
  }
}
