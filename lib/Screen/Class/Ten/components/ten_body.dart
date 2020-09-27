import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Home/home_screen.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/constants.dart';

class TenBody extends StatelessWidget {
  final String id;

  const TenBody({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("This is Ten class page"),
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
