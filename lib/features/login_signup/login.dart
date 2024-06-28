import 'package:flutter/material.dart';
import 'package:vivasayi/Components/custom_button.dart';
import 'package:vivasayi/Components/text_field.dart';
import 'package:vivasayi/Components/text_below.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/login_signup/otp_page.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpPageLogin(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure ScreenUtil is initialized in your main.dart or this context if using it
    // ScreenUtil.init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
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
              SizedBox(height: 73.h),
              const TextBelow(
                textBelow: "Sign In",
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 47.h),
              const MyTextfield(
                hintText: "example@gmail.com",
                labelText: "Email",
              ),
              SizedBox(height: 9.h),
              const TextBelow(
                textBelow: "Email/Phone Number is not Valid",
                color: Color.fromARGB(255, 206, 1, 1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 31.h),
              const MyTextfield(
                hintText: "Password",
                labelText: "Password",
              ),
              SizedBox(height: 9.h),
              const TextBelow(
                textBelow: "Invalid Password",
                color: Color.fromARGB(255, 210, 1, 1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 37.h),
              const TextBelow(
                textBelow: "Forget Password?",
                color: Color.fromARGB(255, 0, 154, 41),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 59.h),
              CustomButton(onTap: login, buttonText: "Sign In"),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 59.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dont have an Account? '),
                    GestureDetector(
                      onTap: widget
                          .onTap, // Assuming onTap is a callback passed to the widget
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
