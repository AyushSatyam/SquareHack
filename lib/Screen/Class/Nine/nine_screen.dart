import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Class/Nine/components/chapture_doubt.dart';
import 'package:squarehack/Screen/Class/Nine/components/chapture_exam.dart';
import 'package:squarehack/Screen/Class/Nine/components/chapture_resource.dart';
import 'package:squarehack/Screen/Class/Nine/components/chapture_video.dart';
// import 'package:squarehack/Screen/Class/Nine/components/nine_body.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:squarehack/constants.dart';
import 'package:squarehack/drawer.dart';

class NineScreen extends StatefulWidget {
  @override
  _NineScreenState createState() => _NineScreenState();
}

class _NineScreenState extends State<NineScreen> {
  int _selectIndex = 0;
  List<Widget> _widgetOption = <Widget>[ChaptureVideo(), ChaptureResource(),ChaptureDoubt(), ChaptureExam()];

  void onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
            "Class - 9",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          // flexibleSpace: ,
        ),
      ),
      body: _widgetOption.elementAt(_selectIndex),
      bottomNavigationBar: CurvedNavigationBar(
        color: kPrimaryLightColor,
        buttonBackgroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.ondemand_video, size: 30),
          Icon(Icons.pages, size: 30),
          Icon(Icons.question_answer, size: 30),
          Icon(Icons.work, size: 30),
          // Icon(Icons.favorite, size: 30),
        ],
        onTap: onItemTapped,
        height: 50,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationCurve: Curves.bounceInOut,
        index: 0,
      ),
    );
  }
}
