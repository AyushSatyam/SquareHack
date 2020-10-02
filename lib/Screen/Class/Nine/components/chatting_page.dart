import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squarehack/Screen/Class/Nine/components/full_image_widget.dart';

class ChattingPage extends StatelessWidget {
  final String recieverName;
  final String recieverId;

  ChattingPage(
      {Key key, @required this.recieverName, @required this.recieverId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.black,
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          recieverName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ChatScreen(recieverId: recieverId),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String recieverId;

  ChatScreen({Key key, this.recieverId}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState(recieverId: recieverId);
}

class _ChatScreenState extends State<ChatScreen> {
  final String recieverId;
  String chatId;
  String id;
  var listMessage;
  File image;
  String imageUrl;
  final ScrollController listScrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  _ChatScreenState({@required this.recieverId});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatId = "";
    readLocal();
  }

  void readLocal() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id") ?? "";
    if (id.hashCode <= recieverId.hashCode) {
      chatId = '$id - $recieverId';
    } else {
      chatId = '$recieverId - $id';
    }
    Firestore.instance
        .collection("Users")
        .document("id")
        .updateData({"chattingWith": recieverId});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              createListMessages(),
              createInput(),
            ],
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CircularProgressIndicator();
    }
    uploadImageFile();
  }

  Future uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Chat Image").child(fileName);
    StorageUploadTask storageUploadTask = storageReference.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot =
        await storageUploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        onSendMessage(imageUrl, 1);
      });
    }, onError: (error) {
      Fluttertoast.showToast(
        msg: "Image Uploading Error",
        backgroundColor: Colors.redAccent,
      );
    });
  }

  createInput() {
    return Container(
      child: Row(
        children: <Widget>[
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.image),
                color: Colors.lightBlueAccent,
                onPressed: () => getImage(),
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.face),
                color: Colors.lightBlueAccent,
                onPressed: () => print("Clicked"),
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: "Write here..",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                focusNode: focusNode,
              ),
            ),
          ),
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.lightBlueAccent,
                onPressed: () => onSendMessage(textEditingController.text, 0),
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        color: Colors.white,
      ),
    );
  }

  void onSendMessage(String contentMessage, int type) {
    if (contentMessage != "") {
      textEditingController.clear();
      var docRef = Firestore.instance
          .collection("Messages")
          .document(chatId)
          .collection(chatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          docRef,
          {
            "idFrom": id,
            "idTo": recieverId,
            "timeStamp": DateTime.now().millisecondsSinceEpoch.toString(),
            "content": contentMessage,
            "type": type,
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: "Empty message can not be send");
    }
  }

  createListMessages() {
    return Flexible(
      child: chatId == ""
          ? CircularProgressIndicator()
          : StreamBuilder(
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                    itemBuilder: (context, index) =>
                        createListItem(index, snapshot.data.document),
                  );
                }
              },
              stream: Firestore.instance
                  .collection("messages")
                  .document(chatId)
                  .collection(chatId)
                  .orderBy(
                    "timeStamp",
                    descending: true,
                  )
                  .limit(20)
                  .snapshots(),
            ),
    );
  }

  createListItem(int index, DocumentSnapshot document) {
    if (document["idFrom"] == id) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          document["type"] == 0
              ? Container(
                  child: Text(
                    document["content"],
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                      right: 10.0),
                )
              : document["type"] == 1
                  ? Container(
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FullPhoto(url: document["content"])));
                        },
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (content, url) => Container(
                              child: CircularProgressIndicator(),
                              width: 200,
                              height: 200,
                              padding: EdgeInsets.all(70),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            errorWidget: (content, url, error) => Material(
                              child: Image.asset(
                                "assets\images\ImageNotAvailable.jpg",
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document["content"],
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          clipBehavior: Clip.hardEdge,
                        ),
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  : Container(),
        ],
      );
    } else {
      return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          child: CachedNetworkImage(
                            imageUrl: null,
                            placeholder: (content, url) => Container(
                              child: CircularProgressIndicator(),
                              width: 35,
                              height: 35,
                              padding: EdgeInsets.all(10),
                            ),
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(
                          width: 35,
                        ),
                  document["type"] == 0
                      ? Container(
                          child: Text(
                            document["content"],
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(8)),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                        )
                      : document["type"] == 1
                          ? Container(
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullPhoto(
                                              url: document["content"])));
                                },
                                child: Material(
                                  child: CachedNetworkImage(
                                    placeholder: (content, url) => Container(
                                      child: CircularProgressIndicator(),
                                      width: 200,
                                      height: 200,
                                      padding: EdgeInsets.all(70),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                    ),
                                    errorWidget: (content, url, error) =>
                                        Material(
                                      child: Image.asset(
                                        "assets\images\ImageNotAvailable.jpg",
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                    imageUrl: document["content"],
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                ),
                              ),
                              margin: EdgeInsets.only(left: 10),
                            )
                          : Container(),
                ],
              ),
              isLastMessageLeft(index)
                  ? Container(
                      child: Text(
                        DateFormat("dd MMMM,yyyy-hh:mm:ss").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(document["timeStamp"]))),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ));
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]["idFrom"] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]["idFrom"] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
