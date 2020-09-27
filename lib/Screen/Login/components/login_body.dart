import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/Screen/Login/components/login_backgroud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:squarehack/Screen/Signup/signup_screen.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/components/rounded_input_field.dart';
import 'package:squarehack/components/rounded_password_field.dart';
import 'package:squarehack/components/already_have_an_account_check.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:squarehack/auth.dart';
// import 'package:squarehack/root.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginBody extends StatefulWidget {
  LoginBody({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

// class  extends State<LoginBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
class _LoginBodyState extends State<LoginBody> {
  // final DocumentReference = Firestore.instance.document("/users/user")
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  String _email, _password;
  // const LoginBody({
  //   Key key,
  // }) : super(key: key);
  // bool showProgress = false;
  // Future<FirebaseUser> _signIn() async {
  //   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

  //   // FirebaseUser user = await _auth.signInWithGoogle(

  //   // )
  // }
  void submit() async {
    try {
      String userId =
          await widget.auth.signInWithEmailAndPassword(_email, _password);
      print('Signed In: $userId');
      Navigator.pushAndRemoveUntil<void>(context, MaterialPageRoute(builder: (_) => HomeScreen(currentUserId: userId,)), (_) => false);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "LOGIN",
              
              press: submit,
              
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupScreen();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
