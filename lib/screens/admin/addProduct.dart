import 'package:flutter/material.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/components/imageUpload/addProductImage.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/services/store.dart';

class AddProduct extends StatelessWidget {
  static String id = "addProduct";
  String _name, _price, _category ,_decription, _imageLocation, _url1, _url2, _url3;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    void setURL (int i , String url){
      switch (i) {
        case 1:
          _url1 = url;
          break;
        case 2:
            _url2 = url;
          break;
        case 3:
            _url3 = url;
          break;
      }
      print ("URL Added");
      print("url 1: $_url1");
      print("url 2: $_url2");
      print("url 3: $_url3");

    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:50),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              CustomTextField(
                hint: "Product Name",
                onClick: (value){
                  _name = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                hint: "Product Price",
                onClick: (value){
                  _price = value;
                },),
              SizedBox(height: 10,),
              CustomTextField(
                hint: "Product Description" ,
                onClick: (value){
                  _decription = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                hint: "Product Category",
                onClick: (value){
                  _category = value;
                },
              ),
              SizedBox(height: 10,),
              CustomTextField(
                hint: "product Location",
                onClick: (value){
                  _imageLocation = value;
                },
              ),
              SizedBox(height: 10,),
              AddImage(setImageUrl: setURL,),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Builder(
                  builder:(context)=> RaisedButton(child: Text("Add Product"), onPressed: () async{
                    if(_globalKey.currentState.validate()){
                      _globalKey.currentState.save();
                      await _store.addProduct(Product(
                            pName: _name,
                            pPrice: _price,
                            pCategory: _category,
                            pDescription: _decription,
                            pLocation: _imageLocation
                        ));
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
