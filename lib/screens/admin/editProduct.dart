import 'package:flutter/material.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/services/store.dart';

class EditProduct extends StatelessWidget {
  static String id = "editProduct";
  String _name, _price, _category ,_decription, _imageLocation;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              CustomTextField(
                initialValue: product.pName,
                hint: "Product Name",
                onClick: (value){
                  _name = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                initialValue: product.pPrice,
                hint: "Product Price",
                onClick: (value){
                  _price = value;
                },),
              SizedBox(height: 10,),
              CustomTextField(
                initialValue: product.pDescription,
                hint: "Product Description" ,
                onClick: (value){
                  _decription = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                initialValue: product.pCategory,
                hint: "Product Category",
                onClick: (value){
                  _category = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                initialValue: product.pLocation,
                hint: "product Location",
                onClick: (value){
                  _imageLocation = value;
                },
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Builder(
                  builder:(context)=> RaisedButton(child: Text("Add Product"), onPressed: () async{
                    if(_globalKey.currentState.validate()){
                      _globalKey.currentState.save();
                      _store.editProduct({
                        pName: _name ?? pName,
                        pPrice: _price ?? _price,
                        pDescription: _decription ?? pDescription,
                        pCategory: _category ?? pCategory,
                        pLocation: _imageLocation ?? pLocation
                      },
                        product.pId );

                    }
                  }
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
