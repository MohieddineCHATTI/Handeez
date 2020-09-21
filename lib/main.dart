import 'package:flutter/material.dart';
import 'package:handeez/components/imageUpload/addProductImage.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/provider/adminMode.dart';
import 'package:handeez/provider/cartItems.dart';
import 'package:handeez/provider/modalHUD.dart';
import 'package:handeez/screens/admin/Orders.dart';
import 'package:handeez/screens/admin/addProduct.dart';
import 'package:handeez/screens/admin/adminPage.dart';
import 'package:handeez/screens/admin/editProduct.dart';
import 'package:handeez/screens/admin/manageProducts.dart';
import 'package:handeez/screens/admin/orderDetails.dart';
import 'package:handeez/screens/loginScreen.dart';
import 'package:handeez/screens/signUpScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:handeez/screens/user/aboutUs.dart';
import 'package:handeez/screens/user/cart.dart';
import 'package:handeez/screens/user/homePage.dart';
import 'package:handeez/screens/user/productInfo.dart';
import 'package:handeez/screens/user/updateCartItem.dart';
import 'package:handeez/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AddImage());
  }
}



class MyApp extends StatelessWidget {
  bool isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot){
        if (!snapshot.hasData){
          return MaterialApp(home: Scaffold(body: Center(child: Text("Loading.."),),));
        }else{
          isLoggedIn = snapshot.data.getBool(keepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<CartItems>(
                create: (context) => CartItems(),
              ),
              ChangeNotifierProvider <ModalHud>(
                  create: (context)=> ModalHud()),
              ChangeNotifierProvider <AdminMode>(
                  create: (context)=> AdminMode()),

            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isLoggedIn ? HomePage.id: LoginScreen.id,
              routes: {
                LoginScreen.id: (context)=> LoginScreen(),
                SignUpScreen.id: (context)=> SignUpScreen(),
                HomePage.id: (context) => HomePage(),
                AdminPage.id: (context) => AdminPage(),
                AddProduct.id: (context) => AddProduct(),
                ManageProducts.id: (context) => ManageProducts(),
                EditProduct.id: (context) => EditProduct(),
                ProductInfo.id: (context) => ProductInfo(),
                Cart.id: (context) => Cart(),
                UpdateCartItem.id : (context) => UpdateCartItem(),
                Orders.id: (context) => Orders(),
                OrderDetails.id: (context) => OrderDetails(),
                AboutUS.id: (context)=> AboutUS(),
              },
            ),

          );
        }
      },
    );
  }
}



