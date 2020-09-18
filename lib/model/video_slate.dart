import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'user_detail.dart';

class VideoSlate extends StatefulWidget {
  final String videoUrl;
  final int commentCount;
  final int likeCount;
  final int shareCount;
  final String title;
  final User user;
  // final dynamic color;
  // VideoSlate({this.color});
  VideoSlate.details(
      {this.videoUrl,
      this.commentCount,
      this.likeCount,
      this.shareCount,
      this.title,
      this.user});

  factory VideoSlate.fromJson(doc) {
    return VideoSlate.details(
      videoUrl: doc['url'],
      commentCount: doc['comment-count'],
      likeCount: doc['like-count '],
      shareCount: doc['share-count'],
      title: doc['title'],
      user: User(
        headshot: doc['user']['headshot'],
        name: doc['user']['name'],
      ),
    );
  }

  @override
  _VideoSlateState createState() => _VideoSlateState();
}

class _VideoSlateState extends State<VideoSlate> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print(widget.videoUrl);
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )
      ..setLooping(true)
      ..initialize().then(
        (_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        },
      );
    // _controller.addListener(() {
    //   print('closure');
    // });
  }

  @override
  // TODO: implement mounted
  bool get mounted => super.mounted;

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
    // setState(() {
    //   (_VideoSlateState().mounted && !_controller.value.isPlaying)
    //       ? _controller.play()
    //       : null;
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('dependencies change');
    //pause
    // setState(() {
    //   _controller.value.isPlaying ? _controller.pause() : null;
    // });
  }

  @override
  void didUpdateWidget(VideoSlate oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('update widget');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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

    // TODO: implement build
    return GestureDetector(
      onTapDown: (tap) {
        print('tap down');
        setState(() {
          _controller.value.isPlaying ? _controller.pause() : null;
        });
      },
      onTap: () {
        print('tap ');
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          minHeight: middleSectionh / 6,
                          minWidth: firstMsectionw,
                        ),
                        // color: Colors.redAccent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              widget.user.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.title.trim() ?? '',
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 15.0,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${widget.commentCount}' ?? '',
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
                          // color: Colors.blueGrey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.share,
                              ),
                              Icon(
                                Icons.share,
                              ),
                              Icon(
                                Icons.share,
                              ),
                              Icon(
                                Icons.share,
                              ),
                              Icon(
                                Icons.share,
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
        ],
      ),
    );
  }
}
