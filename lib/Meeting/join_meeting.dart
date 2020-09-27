import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:squarehack/Meeting/components/join_meeting_body.dart';
import 'package:squarehack/constants.dart';
import 'package:squarehack/drawer.dart';


class JoinMeetingApp extends StatefulWidget {
  @override
  _JoinMeetingAppState createState() => _JoinMeetingAppState();
}

class _JoinMeetingAppState extends State<JoinMeetingApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: MainDrawer(),
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          title: Text(
            "Join a class",
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
        body: JoinMeetingBody(),
      ),
    );
  }

  
}