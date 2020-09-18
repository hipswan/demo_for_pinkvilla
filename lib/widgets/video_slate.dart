import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../model/user_detail.dart';

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
          setState(() {
            _controller.play();
          });
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
    print('deactivate ${_VideoSlateState().mounted} ${widget.user.name}');
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
    print('dependencies change  ${this.mounted} ${widget.user.name}');
    //pause
  }

  @override
  void didUpdateWidget(VideoSlate oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('update widget ${widget.user.name}');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose ${widget.user.name}');
    _controller.pause();
    _controller.dispose();
  }

  buildActionButton(var height, var width) {
    return Container(
      constraints: BoxConstraints(
        minHeight: height / 1.5,
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
    );
  }

  buildMetaData(var width) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      padding: EdgeInsets.only(left: 20.0),
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
                // color: Colors.amber,
                ),
            child: _controller.value.initialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
