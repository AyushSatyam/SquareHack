import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  // Future<String> signInWithGoogle();
}

class Auth implements BaseAuth {
  // Future<GoogleSignInAccount> googleSignIn = GoogleSignIn().signIn();
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password))
        .user;
    // String userName = user.displayName;
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

  // Future<String> signInWithGoogle() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final GoogleSignInAccount account = await GoogleSignIn.standard().signIn();
  //   final GoogleSignInAuthentication _googleAuth = await account.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     idToken: _googleAuth.idToken,
  //     accessToken: _googleAuth.accessToken,
  //   );
  //   String name = account.displayName;
  //   print("Signed In user name: $name");
  //   FirebaseUser user =
  //       (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  //   if (user != null) {
  //     final QuerySnapshot resultQuery = await Firestore.instance
  //         .collection('Users')
  //         .where("id", isEqualTo: user.uid)
  //         .getDocuments();
  //     final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;
  //     if (documentSnapshots.length == 0) {
  //       Firestore.instance.collection("Users").document(user.uid).setData({
  //         "name": user.displayName,
  //         "id": user.uid,
  //         "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
  //         "chattingWith": null,
  //       });
  //       // currentUser = user;
  //       await preferences.setString("id", user.uid);
  //       await preferences.setString("name", user.displayName);
        
  //       // await preferences.setString("name", user.displayName);
  //     }else{
  //        await preferences.setString("id", documentSnapshots[0]["id"]);
  //       await preferences.setString("name", documentSnapshots[0]["name"]);
  //     }
      
  //   }
  //   return user.uid;
  // }
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
