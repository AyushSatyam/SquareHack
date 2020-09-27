import 'dart:io';
// import 'dart:js';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squarehack/Personal_Details/components/personal_detail_background.dart';
import 'package:squarehack/components/rounded_button.dart';
import 'package:squarehack/components/rounded_input_field.dart';
import 'package:squarehack/constants.dart';

class PersonalDetailBody extends StatefulWidget {
  @override
  _PersonalDetailBodyState createState() => _PersonalDetailBodyState();
}

class _PersonalDetailBodyState extends State<PersonalDetailBody> {
  Map data;
  String name;
  String fatherName;
  String dob;
  File _image;
  submit() {
    Map<String, dynamic> demoData = {
      "name": name,
      "Father's name": fatherName,
      "DOB": dob
    };
    CollectionReference collectionReference =
        Firestore.instance.collection('Users');
    collectionReference.add(demoData);
    // uploadPic(context)
  }

  Future getImageUpload() async {
    try {
      final PickedFile image =
          await ImagePicker().getImage(source: ImageSource.gallery);
      setState(() {
        if (image != null) {
          _image = File(image.path);
          print("Image path : $_image");
        } else {
          Fluttertoast.showToast(
            msg: "No image selected",
            backgroundColor: Colors.redAccent,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future uploadPic(BuildContext context) async {
    // getImageUpload();
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRefrence =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRefrence.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    setState(() {
      print("Profile picture uploaded");
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile Picture Uploaded"),
          backgroundColor: Colors.greenAccent,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PersonalDetailBackground(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: kPrimaryColor,
                        child: ClipOval(
                          child: SizedBox(
                              width: 180,
                              height: 180,
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      "https://images.unsplash.com/photo-1513789181297-6f2ec112c0bc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",
                                      fit: BoxFit.fill,
                                    )),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 130, right: 20),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera,
                        size: 40.0,
                      ),
                      onPressed: getImageUpload,
                    ),
                  ),
                ],
              ),
              RoundedInputField(
                hintText: "Enter your name",
                onChanged: (value) {
                  name = value;
                },
              ),
              RoundedInputField(
                hintText: "Enter you father's name",
                onChanged: (value) {
                  fatherName = value;
                },
              ),
              RoundedInputField(
                hintText: "Enter your dob",
                onChanged: (value) {
                  dob = value;
                },
              ),
              // RoundedInputField(),
              // RoundedInputField(),
              // RoundedInputField(),
              RoundedButton(
                text: "Submit",
                press: () {
                  uploadPic(context);
                  submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
