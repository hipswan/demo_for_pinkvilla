import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
      // bottomNavigationBar: Container(
      //   // constraints: BoxConstraints(
      //   //   minHeight: bottomSectionh,
      //   //   minWidth: deviceSize.width,
      //   // ),
      //   decoration: BoxDecoration(),
      //   child: CupertinoTabBar(
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.menu),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.menu),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
