import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:squarehack/Screen/Welcome/welcome_screen.dart';
import 'package:squarehack/auth.dart';
// import 'package:squarehack/Screen/Login/login_screen.dart';
import 'package:squarehack/constants.dart';
import 'package:squarehack/root.dart';
// import 'package:squarehack/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messaging.getToken().then((token) {
      print("Divice Token: ");
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SquareHack',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}
