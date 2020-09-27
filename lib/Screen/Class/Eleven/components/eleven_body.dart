import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/constants.dart';

class ElevenBody extends StatelessWidget {
  final String id;

  const ElevenBody({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is Eleven class page"),
          RoundedButton(
            text: "Home",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen(currentUserId: null,);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
