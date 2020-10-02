import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:squarehack/Screen/Class/Nine/components/chatting_page.dart';
import 'package:squarehack/Screen/Class/Nine/components/user.dart';
import 'package:squarehack/auth.dart';
import 'package:squarehack/components/rounded_button.dart';

class ChaptureDoubt extends StatefulWidget {
  final String currentUserId;

  ChaptureDoubt({Key key, @required this.currentUserId}) : super(key: key);
  @override
  _ChaptureDoubtState createState() =>
      _ChaptureDoubtState(currentUserId: currentUserId);
}

class _ChaptureDoubtState extends State<ChaptureDoubt> {
  final String currentUserId;
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResult;

  _ChaptureDoubtState({Key key, @required this.currentUserId});

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
            // RoundedButton(
            //   text: Text("Chatting Page"),
            //   press: ChatScreen(),
            // )
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
    return FutureBuilder(
      future: futureSearchResult,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<UserResult> searchUserResult = [];
        dataSnapshot.data.documents.forEach((document) {
          User eachUser = User.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          if (currentUserId != document["id"]) {
            searchUserResult.add(userResult);
          }
        });
        return ListView(
          children: searchUserResult,
          shrinkWrap: true,
        );
      },
    );
  }
}

class UserResult extends StatelessWidget {
  final User eachUser;
  UserResult(this.eachUser);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Container(
          color: Colors.blue,
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    // backgroundImage: CachedNetworkImageProvider(eachUser.)
                  ),
                  title: Text(
                    eachUser.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Joined: " +
                        DateFormat("dd MMMM, yyyy - hh:mm:ss").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(eachUser.createdAt))),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                onTap: (){Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChattingPage(recieverId: eachUser.id, recieverName: eachUser.name,)));},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
