import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../model/user_detail.dart';
import '../tik_tok_icons_icons.dart';
import 'dart:math' as math;
import 'package:cached_video_player/cached_video_player.dart';

class VideoSlate extends StatefulWidget {
  final String videoUrl;
  final int commentCount;
  final int likeCount;
  final int shareCount;
  final String title;
  final User user;

  final int pageIndex;
  final int currentPageIndex;
  bool isPaused;
  // final dynamic color;
  // VideoSlate({this.color});
  VideoSlate.details(
      {this.pageIndex,
      this.currentPageIndex,
      this.isPaused,
      this.videoUrl,
      this.commentCount,
      this.likeCount,
      this.shareCount,
      this.title,
      this.user});

  factory VideoSlate.fromJson(doc) {
    return VideoSlate.details(
      videoUrl: doc['url'],
      commentCount: doc['comment-count'],
      likeCount: doc['like-count'],
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

class _VideoSlateState extends State<VideoSlate>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<VideoSlate> {
  bool initialized = false;
  CachedVideoPlayerController _controller;
  AnimationController rotationController;

  get bottomTabBarHeight => 50.0;

  @override
  void initState() {
    super.initState();
    print('Initialize ${widget.pageIndex}');
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    rotationController.forward();
    rotationController.addListener(() {
      setState(() {
        if (rotationController.status == AnimationStatus.completed) {
          rotationController.repeat();
        }
      });
    });
    _controller = CachedVideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then(
        (_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            _controller.play();
            initialized = true;
          });
        },
      );
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _controller.seekTo(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    rotationController.dispose();
    super.dispose();
    // print('dispose ${widget.user.name}');
  }

  getActionButton({IconData icon, String count, double width, double height}) {
    var actionButtomWidth = width / 1.2;
    var actionIconSize = width / 2.5;
    return Container(
      // margin: EdgeInsets.only(
      //   top: 5.0,
      //   bottom: 5.0,
      // ),
      width: actionButtomWidth,
      height: actionButtomWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Icon(
                icon,
                size: actionIconSize,
                color: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: width,
              padding: EdgeInsets.all(10.0),
              child: Text(
                count,
                style: TextStyle(
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getHeadshot({double width, String imageUrl}) {
    double boxWidth = width / 1.3;
    double imageWidth = width / 1.5;

    double headShotBorderWidth = 2;
    return Container(
      width: width,
      height: width,
      child: Stack(children: [
        Center(
          child: Container(
            width: boxWidth,
            height: boxWidth,
            child: Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.pinkAccent.withOpacity(0.8),
                  width: headShotBorderWidth,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(boxWidth / 2),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: boxWidth,
            height: boxWidth,
            child: Center(
              child: Container(
                height: imageWidth,
                width: imageWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(imageWidth / 2),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.user.headshot,
                  imageBuilder: (context, imageProvider) => Container(
                    width: imageWidth,
                    height: imageWidth,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          width: 22,
          height: 22,
          bottom: 3,
          left: ((width / 2) - (22 / 2)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24 / 2)),
          ),
        ),
        Positioned(
          width: 22,
          height: 22,
          bottom: 3,
          left: ((width / 2) - (22 / 2)),
          child: Center(
            child: Icon(
              Icons.add_circle,
              color: Colors.pinkAccent,
              size: 22,
            ),
          ),
        )
      ]),
    );
  }

  LinearGradient get musicGradient => LinearGradient(colors: [
        Colors.grey[800],
        Colors.grey[900],
        Colors.grey[900],
        Colors.grey[800]
      ], stops: [
        0.0,
        0.4,
        0.6,
        1.0
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  getMusicDisc({double width}) {
    double imageWidth = width / 1.5;

    return Container(
        margin: EdgeInsets.only(top: 10.0),
        width: imageWidth,
        height: imageWidth,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
          child: Container(
            padding: EdgeInsets.all(12.0),
            height: imageWidth,
            width: imageWidth,
            decoration: BoxDecoration(
                gradient: musicGradient,
                borderRadius: BorderRadius.circular(imageWidth / 2)),
            child: CachedNetworkImage(
              imageUrl: widget.user.headshot,
              imageBuilder: (context, imageProvider) => Container(
                width: imageWidth,
                height: imageWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ));
    ;
  }

  buildActionButton(var height, var width) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height / 2,
        // minWidth: secondMsectionw,
      ),
      // color: Colors.blueGrey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          getHeadshot(width: width, imageUrl: widget.user.headshot),
          SizedBox(
            height: width / 5,
          ),
          getActionButton(
              icon: TikTokIcons.heart,
              count: '${widget.likeCount} likes',
              width: width),
          getActionButton(
              icon: TikTokIcons.reply,
              count: '${widget.commentCount}',
              width: width),
          getActionButton(
              icon: TikTokIcons.chat_bubble,
              count: '${widget.shareCount}',
              width: width),
          SizedBox(
            height: width / 4,
          ),
          getMusicDisc(width: width),
          SizedBox(
            height: width / 7,
          ),
        ],
      ),
    );
  }

  buildMetaData(var width) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width / 1.5,
      ),
      padding: EdgeInsets.only(left: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '@${widget.user.name}' ?? 'No Data',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            height: 10.0,
          ),
          Text(
            widget.title ?? '',
            softWrap: true,
            textDirection: TextDirection.ltr,
          ),
          Container(
            height: 10.0,
          ),
          Row(children: [
            Icon(Icons.music_note, color: Colors.white, size: 15.0),
            Container(
              width: 10.0,
            ),
            Text('Artist name', style: TextStyle(fontSize: 12.0)),
            Container(
              width: 10.0,
            ),
            Text('Song name', style: TextStyle(fontSize: 12.0))
          ]),
          Container(
            height: 12.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pageIndex == widget.currentPageIndex &&
        !widget.isPaused &&
        initialized) {
      print('condition true called');
      _controller.play();
      rotationController.isAnimating ? null : rotationController.forward();
    } else {
      print('condition true called');
      _controller.pause();
      rotationController.isAnimating ? rotationController.stop() : null;
    }
    final Size deviceSize = MediaQuery.of(context).size;
    // final double topSectionh = deviceSize.height / 8;
    final double middleSectionh = deviceSize.height / 1.25;
    final double firstMsectionw = deviceSize.width / 1.3;

    final double secondMsectionw = deviceSize.width - firstMsectionw;

    // final double bottomSectionh =
    //     deviceSize.height - (topSectionh + middleSectionh);

    // TODO: implement build
    return GestureDetector(
      onTapDown: (tap) {
        print(
            '1.tap down isplaying ${_controller.value.isPlaying} paused ${widget.isPaused} isrotating ${rotationController.isAnimating}  initialised $initialized');
        setState(() {
          widget.isPaused = !widget.isPaused;
        });

        print(
            '2.tap down isplaying ${_controller.value.isPlaying} paused ${widget.isPaused} isrotating ${rotationController.isAnimating}  initialised $initialized');
      },
      onTapUp: (tap) {
        print(
            '1.tap up isplaying ${_controller.value.isPlaying} paused ${widget.isPaused} isrotating ${rotationController.isAnimating}  initialised $initialized');

        setState(() {
          widget.isPaused = !widget.isPaused;
        });

        print(
            '2.tap down isplaying ${_controller.value.isPlaying} paused ${widget.isPaused} isrotating ${rotationController.isAnimating}  initialised $initialized');
      },
      // onTap: () {
      //   print(
      //       'tap isplaying ${_controller.value.isPlaying} paused ${widget.isPaused}');
      //   setState(() {
      //     rotationController.isAnimating && _controller.value.isPlaying
      //         ? rotationController.stop()
      //         : rotationController.forward();
      //     initialized = !initialized;
      //   });
      // },
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: deviceSize.height,
              minWidth: deviceSize.width,
            ),
            decoration: BoxDecoration(
                // color: Colors.amber,
                ),
            child: _controller.value != null && _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CachedVideoPlayer(_controller),
                  )
                : Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
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
                        child: buildMetaData(firstMsectionw),
                      ),
                      //Second element in the middle-upper-section
                      Expanded(
                        child:
                            buildActionButton(middleSectionh, secondMsectionw),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: bottomTabBarHeight,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
