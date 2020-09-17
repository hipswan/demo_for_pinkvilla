import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
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
      bottomNavigationBar: Container(
        // constraints: BoxConstraints(
        //   minHeight: bottomSectionh,
        //   minWidth: deviceSize.width,
        // ),
        decoration: BoxDecoration(),
        child: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(Icons.menu_book_outlined),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.pink,
              icon: Icon(Icons.menu_book_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
