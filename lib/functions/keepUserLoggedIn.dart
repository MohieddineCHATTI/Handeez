import 'package:shared_preferences/shared_preferences.dart';
import 'package:handeez/constants.dart';

void keepUserLoggedIn() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool(keepMeLoggedIn, true);
  print("user saved ");
}