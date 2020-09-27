import 'package:flutter/material.dart';
// import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/Screen/Login/components/login_body.dart';
import 'package:squarehack/auth.dart';
import 'package:squarehack/root.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(
        auth: new Auth(),
        onSignedIn: _signedIn,
      ),
    );
  }
}
