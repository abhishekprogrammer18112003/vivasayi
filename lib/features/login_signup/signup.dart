import 'package:flutter/material.dart';
import 'package:vivasayi/Components/custom_button.dart';
import 'package:vivasayi/Components/text_below.dart';
import 'package:vivasayi/Components/text_field.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 21.h),
              const TextBelow(
                textBelow: "Sign Up",
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 30.h),
              const MyTextfield(
                hintText: "Name",
                labelText: "Name",
              ),
              SizedBox(height: 9.h),
              SizedBox(height: 31.h),
              const MyTextfield(
                hintText: "example@gmail.com",
                labelText: "Email",
              ),
              SizedBox(height: 9.h),
              SizedBox(height: 31.h),
              const MyTextfield(
                hintText: "+91 8887755595",
                labelText: "Phone Number",
              ),
              SizedBox(height: 9.h),
              SizedBox(height: 31.h),
              const MyTextfield(
                hintText: "Password",
                labelText: "Password",
              ),
              SizedBox(height: 31.h),
              const MyTextfield(
                hintText: "Confirm Password",
                labelText: "Confirm Password",
              ),
              SizedBox(height: 9.h),
              const TextBelow(
                textBelow: "Password must be same",
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
              CustomButton(function: () {}, buttonText: "Create Account"),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 59.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Already have an Account? '),
                    GestureDetector(
                      onTap: widget
                          .onTap, // Assuming onTap is a callback passed to the widget
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 47.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
