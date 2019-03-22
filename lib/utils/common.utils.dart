import 'dart:io';

import 'package:flutter/material.dart';

class CommonUtils {
  /*show snack bar for the error and other options*/

  static showSnackBar(
      GlobalKey<ScaffoldState> scaffoldKey, String message, color, bool left) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        backgroundColor: color != null ? color : Colors.red[300],
        duration: Duration(milliseconds: 2000),
        content: new Container(
          height: 15.0,
          alignment: left ? Alignment.topLeft : Alignment.center,
          child: Text(message ?? "You are offline"),
        ),
      ),
    );
  }

  static dynamic get isOnline async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (exception) {
      return false;
    }
  }
}


