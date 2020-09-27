import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Welcome/component/welcome_background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/Screen/Login/login_screen.dart';
import 'package:squarehack/constants.dart';
import 'package:squarehack/Screen/Signup/Signup_screen.dart';
import 'package:squarehack/auth.dart';

// import 'package:squarehack/root.dart';

class WelcomeBody extends StatefulWidget {
  // WelcomeBody({});
  final BaseAuth auth;
  // final VoidCallback onSignedIn;
  const WelcomeBody({
    this.auth,
    // this.onSignedIn,
    Key key,
  }) : super(key: key);
  

  @override
  _WelcomeBodyState createState() => _WelcomeBodyState();
}
// enum AuthStatus {
//   signedIn,
//   notSignedIn,
// }

class _WelcomeBodyState extends State<WelcomeBody> {
  // AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO SQUAREHACK",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
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
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
            ),
          ],
        ),
      ),
    );
  }
}
