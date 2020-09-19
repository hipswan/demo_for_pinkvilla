import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Headshot extends StatelessWidget {
  final String imageUrl;
  final double width;

  Headshot({this.imageUrl, this.width});

  @override
  Widget build(BuildContext context) {
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
                  imageUrl: imageUrl,
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
}
