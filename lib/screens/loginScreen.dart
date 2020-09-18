import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/functions/keepUserLoggedIn.dart';
import 'package:handeez/provider/adminMode.dart';
import 'package:handeez/provider/modalHUD.dart';
import 'package:handeez/screens/admin/adminPage.dart';
import 'package:handeez/screens/signUpScreen.dart';
import 'package:handeez/components/logoWidget.dart';
import 'package:handeez/screens/user/homePage.dart';
import 'package:handeez/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  String _email, _password;

  final _auth = Auth();

  bool isAdmin = false;

  final adminPassword = "Admin1234";

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              LogoWidget(),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                hint: "Enter your email",
                icon: Icons.email,
                onClick: (val) {
                  _email = val;
                },
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                  hint: "Enter your password",
                  icon: Icons.lock,
                  obsc: true,
                  onClick: (val) {
                    _password = val;
                  }),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Remember me", style: TextStyle(
                      color: secondaryColor,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 5,),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: secondaryColor
                      ),
                      child: Checkbox(
                        activeColor: Colors.green,
                        value: rememberMe,
                        onChanged: (value){
                          print("valiue is : $value");
                          setState(() {
                            rememberMe = value;
                          });
                          print("remember me is : $rememberMe");
                        } ,

                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "log in",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    onPressed: () async {
//                      await _auth.signIn("admin1@gmail.com", "Admin1234").then((value) {
//                        Navigator.pushNamed(context, AdminPage.id);
//
//
//                    });
                     _validate(context);
                    }
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don\'t have an account ? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(true);
                      },
                      child: Text(
                        "I \'m an admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? mainColor
                                : Colors.white),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeIsAdmin(false);
                      },
                      child: Text(
                        "I \'m a user",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? Colors.white
                                : mainColor),
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modalHud = Provider.of<ModalHud>(context, listen: false);
    modalHud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
       if (_password == adminPassword){
         await _auth.signIn(_email, _password).then((value) {
           modalHud.changeIsLoading(false);
           if(rememberMe){
             keepUserLoggedIn();
           }

           Navigator.pushNamed(context, AdminPage.id);
         }).catchError((e) {
           modalHud.changeIsLoading(false);
           Scaffold.of(context).showSnackBar(SnackBar(
             content: Text(e.message.toString()),
           ));
         });
       }else{
         modalHud.changeIsLoading(false);
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("something went wrong"),
         ));
       }
      } else {
        await _auth.signIn(_email, _password).then((value) {
          modalHud.changeIsLoading(false);
          if(rememberMe){
            print("i am going to keep it");
            keepUserLoggedIn();
          }
          Navigator.pop(context);
          Navigator.pushNamed(context, HomePage.id);
        }).catchError((e) {
          modalHud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
          ));
        });
      }
    } modalHud.changeIsLoading(false);

  }


}
