import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Welcome/component/welcome_body.dart';
import 'package:squarehack/auth.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomeBody(auth: new Auth(),),
    );
  }
}
