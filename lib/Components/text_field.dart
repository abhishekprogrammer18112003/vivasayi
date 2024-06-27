import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final String labelText;

  const MyTextfield({
    super.key,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(55.w, 0, 48.w, 0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
