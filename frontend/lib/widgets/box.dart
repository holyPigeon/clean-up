// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({
    Key? key,
    required this.width,
    required this.height,
    required this.widget,
  }) : super(key: key);
  final double width;
  final double height;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 248, 248, 248),
      ),
      child: widget,
    );
  }
}
