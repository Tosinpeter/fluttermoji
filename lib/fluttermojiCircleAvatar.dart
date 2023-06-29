import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'fluttermojiController.dart';

/// This widget renders the Fluttermoji of the user on screen
///
/// Accepts a [radius] which defaults to 75.0
/// and a [backgroundColor] which defaults to blueAccent
///
/// Advice the users to set up their Fluttermoji first to avoid unexpected issues.
class FluttermojiCircleAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  FluttermojiCircleAvatar({Key? key, this.radius = 75.0, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null)
      CircleAvatar(radius: radius, child: buildGetX(context));
    return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: buildGetX(context));
  }

  GetX<FluttermojiController> buildGetX(BuildContext context) {
    return GetX<FluttermojiController>(
        init: FluttermojiController(),
        autoRemove: false,
        builder: (mojisnapshot) {
          if (mojisnapshot.fluttermoji.value.isEmpty) {
            return CupertinoActivityIndicator();
          }
          return FutureBuilder<Uint8List>(
              future: mojisnapshot.svgToPng(
                  mojisnapshot.fluttermoji.value, context, 280, 270),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                        radius: radius,
                        backgroundColor: backgroundColor,
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Image.memory(snapshot.data!))),
                  );
                }
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              });
        });
  }
}
