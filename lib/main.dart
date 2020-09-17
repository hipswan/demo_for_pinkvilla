import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: deviceSize.height / 10,
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
                Container(
                  constraints: BoxConstraints(
                    minHeight: deviceSize.height / 1.25,
                    minWidth: deviceSize.width,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          minHeight: deviceSize.height / 1.25,
                          minWidth: deviceSize.width / 1.5,
                        ),
                        color: Colors.redAccent,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: deviceSize.height / 1.25,
                          minWidth: deviceSize.width / 3,
                        ),
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: deviceSize.height / 10,
                    minWidth: deviceSize.width,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                  ),
                  child: CupertinoTabBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_outlined),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.menu_book_outlined),
                      ),
                    ],
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
