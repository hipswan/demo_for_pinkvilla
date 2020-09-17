import 'package:flutter/material.dart';

import 'user_detail.dart';

class VideoSlate extends StatefulWidget {
  String videoUrl;
  int commentCount;
  int likeCount;
  int shareCount;
  String title;
  User user;
  VideoSlate();
  VideoSlate.details(
      {this.videoUrl,
      this.commentCount,
      this.likeCount,
      this.shareCount,
      this.title,
      this.user});

  // factory VideoSlate.fromJson(Map<dynamic, dynamic> doc) {
  //   return VideoSlate(
  //     videoUrl: doc['url'],
  //     commentCount: doc['comment-count'],
  //     likeCount: doc['like-count  '],
  //     shareCount: doc['share-count'],
  //     title: doc['title'],
  //     user: User(
  //       headshot: doc['user']['headshot'],
  //       name: doc['user']['name'],
  //     ),
  //   );
  //}

  @override
  _VideoSlateState createState() => _VideoSlateState();
}

class _VideoSlateState extends State<VideoSlate> {
  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final double topSectionh = deviceSize.height / 8;
    final double middleSectionh = deviceSize.height / 1.25;
    final double firstMsectionw = deviceSize.width / 1.3;

    final double secondMsectionw = deviceSize.width - firstMsectionw;

    final double bottomSectionh =
        deviceSize.height - (topSectionh + middleSectionh);

    // TODO: implement build
    return GestureDetector(
      onVerticalDragDown: (drag) {
        print('drag down');
        //pause
      },
      onVerticalDragStart: (drag) {
        print('drag start');
        //pause
      },
      onVerticalDragEnd: (drag) {
        print('drag end');
      },
      onVerticalDragUpdate: (drag) {
        print(drag);
      },
      onVerticalDragCancel: () {
        print('drag cancel');
        //play
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: deviceSize.height,
          minWidth: deviceSize.width,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  //First element in the middle-upper-section
                  Container(
                    constraints: BoxConstraints(
                      minHeight: middleSectionh,
                      minWidth: firstMsectionw,
                    ),
                    color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '@hipswan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
          ],
        ),
      ),
    );
  }
}
