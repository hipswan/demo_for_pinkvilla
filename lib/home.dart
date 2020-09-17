import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'model/video_slate.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<VideoSlate> videoSlateList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double topSectionh = deviceSize.height / 8;
    final double middleSectionh = deviceSize.height / 1.25;
    final double firstMsectionw = deviceSize.width / 1.3;

    final double secondMsectionw = deviceSize.width - firstMsectionw;

    final double bottomSectionh =
        deviceSize.height - (topSectionh + middleSectionh);

    return Container(
      child: Stack(
        children: <Widget>[
          //Lower pane in the stack for video

          //Middle pane in the stack : for
          PageView(
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              VideoSlate(
                color: Colors.blueAccent,
              ),
              VideoSlate(
                color: Colors.lightBlue,
              ),
            ],
            physics: ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
          ),

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
        ],
      ),
    );
  }
}
