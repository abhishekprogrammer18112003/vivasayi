import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class TextBelow extends StatelessWidget {
  final String textBelow;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  const TextBelow({
    super.key,
    required this.textBelow,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 59.w),
          child: Text(
            textBelow,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}