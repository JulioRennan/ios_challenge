import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FadeContainer extends StatelessWidget {
  Widget child;
  Color? color;
  double? width;
  FadeContainer({
    Key? key,
    required this.child,
    this.width,
    this.color,
  }) : super(key: key);
  RxDouble opacity = 0.0.obs;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500))
        .then((value) => opacity.value = 1);
    return Obx(() {
      return AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: opacity.value,
        child: Container(
          color: color,
          child: child,
          width: width,
        ),
      );
    });
  }
}
