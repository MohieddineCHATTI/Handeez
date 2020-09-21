import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/screens/admin/editProduct.dart';
import 'package:handeez/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handeez/components/customMenu.dart';

class ManageProducts extends StatefulWidget {
  static String id = "manageProduct";

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();

              products.add(Product(
                  pId: doc.id,
                  pName: data[pName],
                  pPrice: data[pPrice],
                  pDescription: data[pDescription],
                  pCategory: data[pCategory],
                  pLocation: data[pLocation],
              url1: data[url1],
              url2: data[url2],
              url3: data[url3]));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.8),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTapUp: (details) {
                    double dxleft = details.globalPosition.dx;
                    double dyup = details.globalPosition.dy;
                    double dxright = MediaQuery.of(context).size.width - dxleft;
                    double dybottom = MediaQuery.of(context).size.height - dyup;

                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            dxleft, dyup, dxright, dybottom),
                        items: [
                          MyPopupMenuItem(
                            child: Text("Edit"),
                            onClick: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, EditProduct.id, arguments: products[index]);
                            },
                          ),
                          MyPopupMenuItem(
                            child: Text("Delete"),
                            onClick: () {
                              _store.deleteProduct(products[index].pId);

                            },
                          ),
                        ]);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: products[index].url1 != null ? Image.network(products[index].url1)
                        : Image(image: AssetImage(
                            "assets/images/${products[index].pLocation}.jpg"),
                      )),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.6,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(products[index].pName),
                                  Text(
                                    "\$ ${products[index].pPrice}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return Center(child: Text("Loading ..."));
          }
        },
      ),
    );
  }
}
