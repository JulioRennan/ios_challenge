import 'package:flutter/material.dart';

import 'fade_container.dart';

class CustomImageLoader extends StatelessWidget {
  String imgPath;
  double width;
  double height;
  Widget? loadingIndicator;
  Color? colorLoader;

  CustomImageLoader(
      {Key? key,
      required this.imgPath,
      this.width = 120,
      this.height = 120,
      this.loadingIndicator,
      this.colorLoader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Image.network(imgPath,
          fit: BoxFit.contain,
          height: width,
          width: height, loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return Center(
            child: loadingIndicator ??
                CircularProgressIndicator(
                  color: colorLoader,
                  strokeWidth: 1,
                  value: getProgress(loadingProgress),
                ),
          );
        }
      }),
    );
  }

  double? getProgress(ImageChunkEvent? loadingProgress) {
    return loadingProgress!.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
        : null;
  }
}
