import 'package:flutter/material.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/components/imageUpload/addProductImage.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/services/store.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class AddProduct extends StatefulWidget {
  static String id = "addProduct";

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _category = jacketsCategory ,_description, _imageLocation, _url1, _url2, _url3;

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

      //TODO delete below commands
      print ("URL Added");
      print("url 1: $_url1");
      print("url 2: $_url2");
      print("url 3: $_url3");

    }
    return Scaffold(
      backgroundColor: mainColor,
      body: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: Padding(
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
                  },
                inputType: TextInputType.number,),
                SizedBox(height: 10,),
                CustomTextField(
                  hint: "Product Description" ,
                  onClick: (value){
                    _description = value;
                  },
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30 ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Category : ", style: TextStyle(

                            fontSize: 16
                          ),),
                          SizedBox(width: 30,),
                          DropdownButton(
                              value: _category,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              elevation: 3,
                              style: TextStyle(
                                fontSize: 16,
                                  color: Colors.black
                              ),
                              onChanged: (val){
                                setState(() {
                                  _category = val;
                                });
                              },
                              items: <String> [jacketsCategory, shoesCategory, trousersCategory, tShirtCategory].map<DropdownMenuItem>((String val) =>
                                  DropdownMenuItem(
                                    value: val,
                                    child: Text(val),
                                  ),
                              ).toList()
                          ),
                        ],
                      ),
                    ),
                  ),
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
                              pDescription: _description,
                              pLocation: _imageLocation,
                              url1: _url1,
                              url2: _url2,
                              url3: _url3
                          ));
                          resetProduct(_globalKey);

                        }
                        }
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetProduct(GlobalKey<FormState> globalKey) {
    Navigator.popAndPushNamed(context, AddProduct.id);
  }
}
