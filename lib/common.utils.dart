import 'package:flutter/material.dart';

class CommonUtils {

  /*show snack bar for the error and other options*/

  static showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message, color) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        backgroundColor: color != null ? color : Colors.red[300],
        duration: Duration(milliseconds: 3000),
        content: new Container(
          height: 20.0,
          alignment: Alignment.center,
          child: Text(message ?? "You are offline"),
        ),
      ),
    );
  }
}
