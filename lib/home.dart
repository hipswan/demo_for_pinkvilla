import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pinkvilla_task/tik_tok_icons_icons.dart';
import 'widgets/video_slate.dart';
import 'dart:convert';

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
    print('Intro');
  }

  Widget buildVideoSlate() {
    return FutureBuilder<http.Response>(
      future:
          http.get('https://www.pinkvilla.com/feed/video-test/video-feed.json'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        List<dynamic> jsonData = jsonDecode(snapshot.data.body);
        print(snapshot.data);

        videoSlateList = jsonData
            .map(
              (e) => VideoSlate.fromJson(e),
            )
            .toList();

        return PageView(
          scrollDirection: Axis.vertical,
          children: videoSlateList,
          physics: ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        );
      },
    );
  }

  buildCentreIcon() {
    return Container(
      width: 45.0,
      height: 27.0,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(left: 10.0),
              width: 40.0,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 45, 108),
                  borderRadius: BorderRadius.circular(7.0))),
          Container(
              margin: EdgeInsets.only(right: 10.0),
              width: 40.0,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 32, 211, 234),
                  borderRadius: BorderRadius.circular(7.0))),
          Center(
            child: Container(
              height: double.infinity,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Icon(
                Icons.add,
                size: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
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
          buildVideoSlate(),
          //Middle pane in the stack : for

          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 50,
                  ),
                  width: deviceSize.width,
                  height: topSectionh,
                  // color: Colors.amberAccent,
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
                Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(TikTokIcons.home,
                                color: Colors.white, size: 20.0),
                            Icon(TikTokIcons.search,
                                color: Colors.white, size: 20.0),
                            buildCentreIcon(),
                            Icon(TikTokIcons.messages,
                                color: Colors.white, size: 20.0),
                            Icon(TikTokIcons.profile,
                                color: Colors.white, size: 20.0)
                          ],
                        ),
                      ),
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
