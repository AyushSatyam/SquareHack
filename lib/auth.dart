import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<String> signInWithGoogle();
}

class Auth implements BaseAuth {
  Future<GoogleSignInAccount> googleSignIn = GoogleSignIn().signIn();
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await GoogleSignIn.standard().signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    String name = account.displayName;
    print("Signed In user name: $name");
    return (await FirebaseAuth.instance.signInWithCredential(credential))
        .user
        .uid;
  }
}

// googleSignIn.signIn().then((result) {
//                         result.authentication.then((googleKey) {
//                           FirebaseAuth.instance
//                               .signInWithCredential(
//                                   GoogleAuthProvider.getCredential(
//                             idToken: googleKey.idToken,
//                             accessToken: googleKey.accessToken,
//                           ))
//                               .then((signedInUser) {
//                             print(result.displayName);
//                             print("Signed in as $signedInUser");
//                             AuthStatus.signedIn;
//                             Navigator.pushAndRemoveUntil<void>(
//                                 context,
//                                 MaterialPageRoute(builder: (_) => HomeScreen(result.id)),
//                                 (_) => false);
//                           }).catchError((e) {
//                             print(e);
//                           });
//                         }).catchError((e) {
//                           print(e);
//                         });
//                       }).catchError((e) {
//                         print(e);
//                       });
