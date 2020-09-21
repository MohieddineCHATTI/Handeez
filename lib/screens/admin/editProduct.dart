import 'package:flutter/material.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/components/imageUpload/addProductImage.dart';
import 'package:handeez/components/imageUpload/editProductImage.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/services/store.dart';

class EditProduct extends StatefulWidget {
  static String id = "editProduct";

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  void setURL(int i, String url) {
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
    print("URL Added");
    print("url 1: $_url1");
    print("url 2: $_url2");
    print("url 3: $_url3");
  }

  String _name,
      _price,
      _category,
      _description,
      _url1,
      _url2,
      _url3;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              CustomTextField(
                initialValue: product.pName,
                hint: "Product Name",
                onClick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                initialValue: product.pPrice,
                hint: "Product Price",
                onClick: (value) {
                  _price = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                initialValue: product.pDescription,
                hint: "Product Description",
                onClick: (value) {
                  _description = value;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Category : ",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        DropdownButton(
                            value: product.pCategory,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            elevation: 3,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            onChanged: (val) {
                              setState(() {
                                _category = val;
                              });
                            },
                            items: <String>[
                              jacketsCategory,
                              shoesCategory,
                              trousersCategory,
                              tShirtCategory
                            ]
                                .map<DropdownMenuItem>(
                                  (String val) => DropdownMenuItem(
                                    value: val,
                                    child: Text(val),
                                  ),
                                )
                                .toList()),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              EditImage(
                setImageUrl: setURL,
                product: product,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: Builder(
                  builder: (context) => RaisedButton(
                      child: Text("Update Product"),
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          await _store.editProduct({
                            pName: _name ?? product.pName,
                            pPrice: _price ?? product.pPrice,
                            pDescription: _description ?? product.pDescription,
                            pCategory: _category ?? product.pCategory,
                            url1: _url1 ?? product.url1,
                            url2: _url2 ?? product.url2,
                            url3: _url3 ?? product.url3,
                          }, product.pId);
                          Navigator.pop(context);
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
