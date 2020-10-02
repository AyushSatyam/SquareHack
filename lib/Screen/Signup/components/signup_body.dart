// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/Screen/Signup/components/signup_background.dart';
import 'package:squarehack/components/rounded_input_field.dart';
import 'package:squarehack/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/components/already_have_an_account_check.dart';
import 'package:squarehack/Screen/Login/login_screen.dart';
import 'package:squarehack/Screen/Signup/components/or_divider.dart';
import 'package:squarehack/Screen/Signup/components/social_icon.dart';
import 'package:squarehack/auth.dart';

import 'package:squarehack/root.dart';
// import 'package:squarehack/root.dart';

class SignupBody extends StatefulWidget {
  // final VoidCallback onSignedIn;
  SignupBody({
    this.auth,
    // this.authStatus,
    // this.authStatus = false,
    // this.onSignedIn
  });
  final BaseAuth auth;
  // final AuthStatus authStatus;
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  AuthStatus authStatus;
  SharedPreferences preferences;
  bool isLoggedIn = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
//   Future<FirebaseUser> handleSignIn() async {
//   final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

//   final FirebaseUser user = await _auth.signInWithGoogle(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//   print("signed in " + user.displayName);
//   return user;
// }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      isLoggedIn = false;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(currentUserId: preferences.get("id"))));
    }
  }

  void submit() async {
    try {
      String userId =
          await widget.auth.createUserWithEmailAndPassword(_email, _password);
      print('Registered In: $userId');
      // AuthStatus.signedIn;
      Navigator.pushAndRemoveUntil<void>(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (_) => false);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Null> signInWithGoogle() async {
    preferences = await SharedPreferences.getInstance();
    final GoogleSignInAccount account = await googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    String name = account.displayName;
    print("Signed In user name: $name");
    FirebaseUser user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if (user != null) {
      final QuerySnapshot resultQuery = await Firestore.instance
          .collection('Users')
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;
      if (documentSnapshots.length == 0) {
        Firestore.instance.collection("Users").document(user.uid).setData({
          "name": user.displayName,
          "id": user.uid,
          "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
          "chattingWith": null,
        });
        // currentUser = user;
        await preferences.setString("id", user.uid);
        await preferences.setString("name", user.displayName);

        // await preferences.setString("name", user.displayName);
      } else {
        await preferences.setString("id", documentSnapshots[0]["id"]);
        await preferences.setString("name", documentSnapshots[0]["name"]);
      }
      print("Signed in with Google: ${user.uid}");
      // Navigator.pushAndRemoveUntil<void>(context,
      // MaterialPageRoute(builder: (_) => HomeScreen(user.uid)), (_) => false);
      // return user.uid;
      setState(() {
        print("Congratulation! Signin successful");
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Congratulation! Signin successful"),
            backgroundColor: Colors.greenAccent,
          ),
        );
        // AuthStatus.signedIn;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(currentUserId: preferences.get("id"))));
      });
    } else {
      setState(() {
        print("Try again! Signin failed");
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Try again! Signin failed"),
            backgroundColor: Colors.redAccent,
          ),
        );
        // authStatus = AuthStatus.notSignedIn;
      });
    }
  }

  // void googleSignIn() async {
  //   // final userId = await widget.auth.signInWithGoogle();

  //   // FirebaseUser firebaseUser =
  //   final QuerySnapshot resultQuery = await Firestore.instance
  //       .collection('Users')
  //       .where("id", isEqualTo: userId)
  //       .getDocuments();
  //   final List<DocumentSnapshot> documentSnapshots = resultQuery.documents;
  //   // if(userId!=null){

  //   // }else{

  //   // }
  //   Navigator.pushAndRemoveUntil<void>(context,
  //       MaterialPageRoute(builder: (_) => HomeScreen(userId)), (_) => false);
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SignupBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                _email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                _password = value;
              },
            ),
            RoundedButton(
              text: "Sign Up",
              press: submit,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            orDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconscr: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconscr: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconscr: "assets/icons/google-plus.svg",
                  press: signInWithGoogle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
