import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Class/Eleven/eleven_screen.dart';
import 'package:squarehack/Screen/Class/Nine/nine_screen.dart';
import 'package:squarehack/Screen/Class/Ten/ten_screen.dart';
import 'package:squarehack/Screen/Class/Twelf/twelf_screen.dart';
import 'package:squarehack/Screen/Welcome/component/welcome_background.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/Screen/Login/login_screen.dart';
import 'package:squarehack/constants.dart';
// import 'package:squarehack/Screen/Signup/Signup_screen.dart';
// import 'package:squarehack/auth.dart';

// import 'package:squarehack/root.dart';

class HomeBody extends StatefulWidget {
  // final String id;
  // HomeBody(this.id);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
              "SELECT YOUR CLASS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              "CLASS 9-12",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.15),
                RoundedButton(
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  text: "9th",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NineScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(width: size.width * 0.08),
                RoundedButton(
                  text: "10th",
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TenScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.05),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.15),
                RoundedButton(
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  text: "11th",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ElevenScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(width: size.width * 0.08),
                RoundedButton(
                  text: "12th",
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TwelfScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: size.height * 0.05),
            Text(
              "EXAM PREPARATION",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.15),
                RoundedButton(
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  text: "9th",
                  press: () {},
                ),
                SizedBox(width: size.width * 0.08),
                RoundedButton(
                  text: "10th",
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  press: () {},
                ),
              ],
            ),
            // SizedBox(height: size.height * 0.05),
            Row(
              children: <Widget>[
                SizedBox(width: size.width * 0.15),
                RoundedButton(
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  text: "11th",
                  press: () {},
                ),
                SizedBox(width: size.width * 0.08),
                RoundedButton(
                  text: "12th",
                  color: kPrimaryLightColor,
                  textColor: Colors.blueAccent,
                  press: () {},
                ),
              ],
            ),
            RoundedButton(
              text: "Login",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
          ],
        ),
      ),
    );
  }
}
