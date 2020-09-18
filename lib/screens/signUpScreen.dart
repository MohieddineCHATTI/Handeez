import 'package:flutter/material.dart';
import 'package:handeez/constants.dart';
import 'package:handeez/components/customTextField.dart';
import 'package:handeez/provider/modalHUD.dart';
import 'file:///C:/Users/Moh/Desktop/Flutter/Flutter/handeez/lib/screens/user/homePage.dart';
import 'package:handeez/screens/loginScreen.dart';
import 'package:handeez/components/logoWidget.dart';
import 'package:handeez/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "signUpScreen";
  String _email, _password, _name;
  final _auth = Auth();
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
                  hint: "Enter your name",
                  icon: Icons.perm_identity,
                  onClick: (val) {
                    _name = val;
                  }),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                  hint: "Enter your email",
                  icon: Icons.email,
                  onClick: (val) {
                    _email = val;
                  }),
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
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      final modalHud =
                          Provider.of<ModalHud>(context, listen: false);
                      modalHud.changeIsLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        _auth.signUp(_email, _password, _name).then((value) {
                          modalHud.changeIsLoading(false);
                          Navigator.pushNamed(context, HomePage.id);
                        }).catchError((e) {
                          modalHud.changeIsLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message.toString()),
                          ));
                        });
                      } else {
                        modalHud.changeIsLoading(false);
                      }
                    },
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
                    "Already have an account ? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
