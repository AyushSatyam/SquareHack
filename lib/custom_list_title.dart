import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  
  final Function onTap;
  final IconData icon;
  final String text;


  const CustomListItem({Key key, this.onTap, this.icon, this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: InkWell(
        splashColor: Colors.purpleAccent,
        onTap: onTap,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Icon(icon),
                  Padding(
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                      padding: EdgeInsets.all(10))
                ],
              ),
              Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
