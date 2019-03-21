import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
              child: IconButton(
                icon: Icon(Icons.cloud_download),
                iconSize: 40.0,
                color: Colors.blueAccent,
                onPressed: () {
                  print('open form for user name & password');
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid)),
              child: IconButton(
                icon: Icon(Icons.send),
                iconSize: 40.0,
                color: Colors.blueAccent,
                onPressed: () {
                  print('open form for user name & password');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
