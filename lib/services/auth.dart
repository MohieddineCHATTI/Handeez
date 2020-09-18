import 'package:firebase_auth/firebase_auth.dart';


class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password, String name) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    await authResult.user.updateProfile(displayName: name);
    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authresult = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    return authresult;
  }

  Future <User> currentUser()async{
    User user = _auth.currentUser;
    return user;
  }


  Future<void> signOUt ()async{
    await _auth.signOut();
  }

//  Stream<User> isUserLogged() {
//    return _auth.authStateChanges();
}

