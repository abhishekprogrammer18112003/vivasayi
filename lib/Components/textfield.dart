import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class MyTextfield extends StatelessWidget {
  final String? hintText;
  final String labelText;
  final TextEditingController controller;
 TextInputType? type;
  final String? Function(String?)? validator;

  MyTextfield({
    super.key,
    this.hintText,
    required this.labelText,
    required this.controller,
    this.validator,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        
      ),
      
      validator: validator,
    );
  }
}


