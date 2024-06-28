import 'package:flutter/material.dart';
import 'package:vivasayi/Components/custom_button.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class SucessPage extends StatelessWidget {
  const SucessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 92.h),
        const Text(
          'Success !',
          style: TextStyle(
              fontSize: 36,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 54.h),
        const Text(
          'Your account has been created',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 91.h),
        Image.asset(
          'assets/check-mark 2.png',
          width: 329.w,
          height: 300.h,
        ),
        SizedBox(height: 120.h),
        CustomButton(onTap: () {}, buttonText: "Continue"),
        SizedBox(height: 40.h),
      ],
    );
  }
}
