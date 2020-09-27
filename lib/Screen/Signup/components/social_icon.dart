import 'package:flutter/material.dart';
import 'package:squarehack/constants.dart';
import 'package:flutter_svg/svg.dart';

class SocialIcon extends StatelessWidget {
  final String iconscr;
  final Function press;

  const SocialIcon({Key key, this.iconscr, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
        ),
        child: SvgPicture.asset(
          iconscr,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
