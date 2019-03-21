import 'package:code_scann/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(ScannerCode());


class ScannerCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}
