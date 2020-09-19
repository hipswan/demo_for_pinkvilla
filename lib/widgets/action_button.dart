import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;
  final String count;
  const ActionButton({this.icon, this.width, this.height, this.count});

  @override
  Widget build(BuildContext context) {
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
}
