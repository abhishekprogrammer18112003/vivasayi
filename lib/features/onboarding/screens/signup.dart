// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unnecessary_import
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/onboarding/data/onboarding_provider.dart';
import 'package:vivasayi/features/onboarding/screens/login.dart';
import 'package:vivasayi/features/onboarding/screens/otp_page.dart';
import 'package:vivasayi/features/onboarding/widgets/my_text_field.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Consumer<OnboardingProvider>(
            builder: (context, value, child) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSpacers.height56,
                  Center(
                    child: Image.asset(
                      AppIcons.appLogo,
                      width: 145.w,
                      height: 144.h,
                    ),
                  ),
                  CustomSpacers.height21,
                  Text(
                    "Sign Up",
                    style:
                        TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Name",
                    controller: _nameController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please Enter name";
                      }
                    },
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Email",
                    controller: _emailController,
                    type: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Phone Number",
                    controller: _phoneController,
                    type: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter phone number";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Password",
                    controller: _passwordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Confirm Password",
                    controller: _confirmPasswordController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter confirm password";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Already have an Account? ',
                        style: TextStyle(
                            fontSize: 17.w, fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  CustomSpacers.height32,
                  !value.isLoading
                      ? CustomButton(
                          strButtonText: "Create Account",
                          buttonAction: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                OverlayManager.showToast(
                                    type: ToastType.Alert,
                                    msg: "Password must be same");
                              } else {
                                await value.signup(
                                    _phoneController.text,
                                    context,
                                    _nameController.text,
                                    _emailController.text,
                                    _passwordController.text);
                              }
                            }
                          },
                          dHeight: 69.h,
                          dWidth: 369.w,
                          bgColor: Colors.green,
                          dCornerRadius: 12,
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                  CustomSpacers.height40,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
