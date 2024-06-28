import 'package:flutter/material.dart';
import 'package:vivasayi/Components/custom_button.dart';
import 'package:vivasayi/Components/text_below.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/login_signup/sucess_page.dart';

class OtpPageLogin extends StatefulWidget {
  const OtpPageLogin({super.key});

  @override
  State<OtpPageLogin> createState() => _OtpPageLoginState();
}

class _OtpPageLoginState extends State<OtpPageLogin> {
  void verify() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SucessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 56.h),
        Center(
          child: Image.asset(
            'assets/vivasayi_logo.png',
            width: 145.w,
            height: 144.h,
          ),
        ),
        SizedBox(height: 64.h),
        const TextBelow(
          textBelow: "Enter OTP",
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 20.h),
        const TextBelow(
          textBelow: "Password must be same",
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 29.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => SizedBox(
              width: 63.h,
              height: 43.h,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.h, color: const Color.fromARGB(255, 0, 0, 0)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: TextField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(
                        fontSize: 20), // Adjust font size of hint text
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: const TextStyle(
                      fontSize: 22), // Adjust font size of entered digits
                  onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      // Move focus to the next OTP input box
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 25.h),
        const TextBelow(
          textBelow: "Wrong OTP Entered",
          color: Color.fromARGB(255, 200, 0, 0),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 59.w),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Code  will expire in: '),
              Text(
                '1 : 20',
                style: TextStyle(
                    color: Color.fromARGB(255, 184, 1, 1),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(height: 27.h),
        const TextBelow(
          textBelow: "Resend Code",
          color: Color.fromARGB(255, 49, 182, 0),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 91.h),
        CustomButton(onTap: verify, buttonText: "Verify"),
        SizedBox(height: 40.h),
      ],
    );
  }
}
