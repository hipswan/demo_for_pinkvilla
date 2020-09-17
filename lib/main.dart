import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
    final Size deviceSize = MediaQuery.of(context).size;
    final double topSectionh = deviceSize.height / 8;
    final double middleSectionh = deviceSize.height / 1.25;
    final double firstMsectionw = deviceSize.width / 1.3;

    final double secondMsectionw = deviceSize.width - firstMsectionw;

    final double bottomSectionh =
        deviceSize.height - (topSectionh + middleSectionh);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          //Lower pane in the stack for video
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
          ),
          //Upper pane in the stack for details
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            child: Column(
              children: [
                //Top Section in the Upper Laywer
                Container(
                  constraints: BoxConstraints(
                    minHeight: topSectionh,
                    minWidth: deviceSize.width,
                  ),
                  color: Colors.amberAccent,
                  child: Row(
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Following',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'For You',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Middle Section in the Upper Layer
                Container(
                  constraints: BoxConstraints(
                    minHeight: middleSectionh,
                    minWidth: deviceSize.width,
                  ),
                  child: Row(
                    children: <Widget>[
                      //First element in the middle-upper-section
                      Container(
                        constraints: BoxConstraints(
                          minHeight: middleSectionh,
                          minWidth: firstMsectionw,
                        ),
                        // color: Colors.redAccent,
                      ),
                      //Second element in the middle-upper-section
                      Container(
                        constraints: BoxConstraints(
                          minHeight: middleSectionh,
                          minWidth: secondMsectionw,
                        ),
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
                //Bottom Section in the Upper Layer
                Expanded(
                  child: Container(
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
