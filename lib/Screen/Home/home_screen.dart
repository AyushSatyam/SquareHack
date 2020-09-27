import 'package:flutter/material.dart';
import 'package:squarehack/Screen/Home/components/home_body.dart';

class HomeScreen extends StatefulWidget {
  final String id;
  HomeScreen(this.id);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(widget.id),
    );
  }
}
