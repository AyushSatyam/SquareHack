import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
// import 'package:squarehack/Screen/Login/login_screen.dart';
// import 'package:squarehack/Screen/Login/components/login_backgroud.dart';
import 'package:squarehack/Screen/Welcome/welcome_screen.dart';
// import 'package:squarehack/Screen/Login/login_screen.dart';
// import 'package:squarehack/Screen/Welcome/welcome_screen.dart';
import 'package:squarehack/auth.dart';
// import 'auth.dart';

class RootPage extends StatefulWidget {
  final String id;
  RootPage({this.auth, this.id});
  final BaseAuth auth;
  @override
  _RootPageState createState() => _RootPageState(id);
}

enum AuthStatus {
  signedIn,
  notSignedIn,
}

class _RootPageState extends State<RootPage> {
  final String id;
  AuthStatus authStatus = AuthStatus.notSignedIn;

  _RootPageState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        Fluttertoast.showToast(
          msg: "Error in Signing In",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          // timeInSecForAndroid: 1
        );
        return new WelcomeScreen();
        break;
      case AuthStatus.signedIn:
        Fluttertoast.showToast(
          msg: "Signed In successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.blue,
          // timeInSecForAndroid: 1
        );
        return new HomeScreen(currentUserId: null,);
        break;
    }
    // return new WelcomeScreen();
  }
}
