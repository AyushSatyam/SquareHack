import 'package:flutter/material.dart';
import 'package:squarehack/constants.dart';
import 'package:squarehack/custom_list_title.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  kPrimaryColor,
                  Colors.purpleAccent,
                ],
              ),
            ),
            child: Container(
              child: Column(
                children: [
                  Material(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        "assets/images/potrait.png",
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    elevation: 10,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "This is drawer section",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomListItem(
            text: "person",
            onTap: () {},
            icon: Icons.person,
          ),
          CustomListItem(
            text: "Notification",
            onTap: () {},
            icon: Icons.notifications,
          ),
          CustomListItem(
            text: "Setting",
            icon: Icons.settings,
            onTap: () {},
          ),
          CustomListItem(
            text: "Logout",
            onTap: () {},
            icon: Icons.exit_to_app,
          ),
        ],
      ),
    );
  }
}
