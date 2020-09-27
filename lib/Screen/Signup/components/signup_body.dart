// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
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

class SignupBody extends StatefulWidget {
  // final VoidCallback onSignedIn;
  SignupBody({
    this.auth,
    // this.authStatus = false,
    // this.onSignedIn
  });
  final BaseAuth auth;
  // final bool authStatus;
  @override
  _SignupBodyState createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;

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

  void submit() async {
    try {
      String userId =
          await widget.auth.createUserWithEmailAndPassword(_email, _password);
      print('Registered In: $userId');
      AuthStatus.signedIn;
      Navigator.pushAndRemoveUntil<void>(context,
          MaterialPageRoute(builder: (_) => LoginScreen()), (_) => false);
    } catch (e) {
      print('Error: $e');
    }
  }

  void googleSignIn() async {
    final userId = await widget.auth.signInWithGoogle();
    print("Signed in with Google: $userId");
    Navigator.pushAndRemoveUntil<void>(context,
          MaterialPageRoute(builder: (_) => HomeScreen(userId)), (_) => false);
  }

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
                    iconscr: "assets/icons/google-plus.svg", press: googleSignIn)
              ],
            )
          ],
        ),
      ),
    );
  }
}
