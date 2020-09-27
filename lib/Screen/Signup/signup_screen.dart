import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Signup/components/signup_body.dart';
import 'package:squarehack/auth.dart';
// import 'package:squarehack/root.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // AuthStatus authStatus = AuthStatus.notSignedIn;

  // void _signedIn() {
  //   setState(() {
  //     authStatus = AuthStatus.signedIn;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupBody(auth: new Auth(),),
    );
  }
}
