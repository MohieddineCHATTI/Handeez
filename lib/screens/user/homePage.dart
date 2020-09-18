import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/modals/product.dart';
import 'package:handeez/screens/loginScreen.dart';
import 'package:handeez/screens/user/cart.dart';
import 'package:handeez/services/auth.dart';
import 'package:handeez/services/store.dart';
import 'package:handeez/components/productView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static String id = "homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  Auth _auth = Auth();
  User currentUser ;

  @override
  void initState(){
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: mainColor,
                elevation: 0,
                bottom: TabBar(
                    indicatorColor: Colors.red,
                    onTap: (index) {
                      setState(() {
                        _tabBarIndex = index;
                      });
                    },
                    tabs: [
                      Text(
                        "Jackets",
                        style: TextStyle(
                          color:
                              _tabBarIndex == 0 ? Colors.white : Colors.white54,
                          fontSize: _tabBarIndex == 0 ? 16 : null,
                        ),
                      ),
                      Text("Trousers",
                          style: TextStyle(
                            color: _tabBarIndex == 1
                                ? Colors.white
                                : Colors.white54,
                            fontSize: _tabBarIndex == 1 ? 16 : null,
                          )),
                      Text("T-Shirts",
                          style: TextStyle(
                            color: _tabBarIndex == 2
                                ? Colors.white
                                : Colors.white54,
                            fontSize: _tabBarIndex == 2 ? 16 : null,
                          )),
                      Text("Shoes",
                          style: TextStyle(
                            color: _tabBarIndex == 3
                                ? Colors.white
                                : Colors.white54,
                            fontSize: _tabBarIndex == 3 ? 16 : null,
                          )),
                    ]),
              ),
              body: TabBarView(
                children: [
                  productView(jacketsCategory),
                  productView(trousersCategory),
                  productView(tShirtCategory),
                  productView(shoesCategory),
                ],
              ),
            )),
        Material(
          child: Container(
            color: mainColor,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentUser!=null) Text(
                    currentUser.displayName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          Navigator.pushNamed(context, Cart.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close,),
                        onPressed: () async {
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          pref.setBool(keepMeLoggedIn, false);
                          await _auth.signOUt();
                          Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void getUser() async {
    User user =  await _auth.currentUser();
    setState(() {
      currentUser = user;
    });

  }

//  Widget productView(category) {
//      return  StreamBuilder<QuerySnapshot>(
//        stream: _store.loadProducts(),
//        builder: (context, snapshot) {
//          if (snapshot.hasData) {
//            List<Product> products = [];
//            for (var doc in snapshot.data.docs) {
//              var data = doc.data();
//                  products.add(Product(
//                      pId: doc.id,
//                      pName: data[pName],
//                      pPrice: data[pPrice],
//                      pDescription: data[pDescription],
//                      pCategory: data[pCategory],
//                      pLocation: data[pLocation]));
//                }
//            _products = [...products];
//            products.clear();
//            products = getProductByCategory(category);
//
//            return GridView.builder(
//              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2, childAspectRatio: 0.8),
//              itemBuilder: (context, index) => Padding(
//                padding: const EdgeInsets.all(10),
//                child: GestureDetector(
//                  child: Stack(
//                    children: [
//                      Positioned.fill(
//                          child: Image(
//                            fit: BoxFit.fill,
//                            image: AssetImage(
//                                "assets/images/${products[index].pLocation}.jpg"),
//                          )),
//                      Positioned(
//                        bottom: 0,
//                        child: Opacity(
//                          opacity: 0.6,
//                          child: Container(
//                            width: MediaQuery.of(context).size.width,
//                            height: 50,
//                            color: Colors.white,
//                            child: Padding(
//                              padding: const EdgeInsets.symmetric(
//                                  horizontal: 10, vertical: 5),
//                              child: Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: [
//                                  Text(products[index].pName),
//                                  Text(
//                                    "\$ ${products[index].pPrice}",
//                                    style:
//                                    TextStyle(fontWeight: FontWeight.w700),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              itemCount: products.length,
//            );
//          } else {
//            return Center(child: Text("Loading ..."));
//          }
//        },
//      );
//  }
//
//  List<Product> getProductByCategory(String category) {
//    List<Product> products = [];
//    for (var product in _products){
//      if (product.pCategory == category){
//        products.add(product);
//      }
//    }
//    return products;
//  }
}
