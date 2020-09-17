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
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  constraints: BoxConstraints(
                    minHeight: topSectionh,
                    minWidth: deviceSize.width,
                  ),
                  color: Colors.amberAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        width: 5,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      //First element in the middle-upper-section
                      Container(
                        constraints: BoxConstraints(
                          minHeight: middleSectionh / 6,
                          minWidth: firstMsectionw,
                        ),
                        color: Colors.redAccent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '@hipswan',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Video title'),
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Artist detail',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //Second element in the middle-upper-section
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: middleSectionh / 2,
                            // minWidth: secondMsectionw,
                          ),
                          color: Colors.blueGrey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.access_alarm_outlined,
                              ),
                              Icon(
                                Icons.access_alarm_outlined,
                              ),
                              Icon(
                                Icons.access_alarm_outlined,
                              ),
                              Icon(
                                Icons.access_alarm_outlined,
                              ),
                              Icon(
                                Icons.access_alarm_outlined,
                              ),
                            ],
                          ),
                        ),
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
