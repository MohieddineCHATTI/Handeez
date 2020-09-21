import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/screens/user/productInfo.dart';
import 'package:handeez/services/store.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/functions/getProductByCategory.dart';

Widget productView(category) {
  List<Product> _products = [];
  final _store = Store();
  return StreamBuilder<QuerySnapshot>(
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
        _products = [...products];
        products.clear();
        products = getProductByCategory(category, _products);

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.8),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: products[index]);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image(
                    fit: BoxFit.fill,
                    image: products[index].url1 ==null ? AssetImage(
                        "assets/images/${products[index].pLocation}.jpg") : NetworkImage(products[index].url1),
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
                                style: TextStyle(fontWeight: FontWeight.w700),
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
  );
}
