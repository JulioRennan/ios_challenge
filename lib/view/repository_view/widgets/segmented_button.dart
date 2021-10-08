import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SegmentedButton extends StatelessWidget {
  String title;
  Widget icon;
  SegmentedButton({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(title)
        ],
      ),
      width: Get.width * 0.5,
      height: 50,
      alignment: Alignment.center,
    );
  }
}
