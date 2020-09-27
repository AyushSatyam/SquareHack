import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:squarehack/auth.dart';

class ChaptureDoubt extends StatefulWidget {
  @override
  _ChaptureDoubtState createState() => _ChaptureDoubtState();
}

class _ChaptureDoubtState extends State<ChaptureDoubt> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResult;

  void emptyTextFormField() {
    searchTextEditingController.clear();
  }

  void controlSearching(String userName) {
    // BaseAuth user = BaseAuth();

    Future<QuerySnapshot> allUsers = Firestore.instance
        .collection("Users")
        .where("name", isGreaterThanOrEqualTo: userName)
        .getDocuments();
    setState(() {
      futureSearchResult = allUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              style: TextStyle(fontSize: 18.0, color: Colors.white),
              controller: searchTextEditingController,
              decoration: InputDecoration(
                hintText: "Seach your teacher..",
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                prefixIcon: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 30.0,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                  onPressed: emptyTextFormField,
                ),
              ),
              onFieldSubmitted: controlSearching,
            ),
            futureSearchResult == null
                ? displayNoUserFoundScreen()
                : displayUserFoundScreen(),
            Text("This is doubt section"),
          ],
        ),
      ),
    );
  }

  displayNoUserFoundScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return SingleChildScrollView(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(
              Icons.group,
              color: Colors.lightBlueAccent,
              size: 200,
            ),
            Text(
              "Search User",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 50,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  displayUserFoundScreen() {
    return FutureBuilder(builder: (context, dataSnapshot) {
      if (!dataSnapshot.hasData) {
        return CircularProgressIndicator();
      }
      // List<UserResult> searchUserResult = [];
    },);
  }
}
