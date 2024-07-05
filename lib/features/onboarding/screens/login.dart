import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/nav_bar.dart';
import 'package:vivasayi/features/onboarding/data/onboarding_provider.dart';
import 'package:vivasayi/features/onboarding/screens/login_with_otp_screen.dart';
import 'package:vivasayi/features/onboarding/screens/signup.dart';
import 'package:vivasayi/features/onboarding/widgets/my_text_field.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Ensure ScreenUtil is initialized in your main.dart or this context if using it
    // ScreenUtil.init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Form(
            key: _formKey1,
            child: Consumer<OnboardingProvider>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 56.h),
                  Center(
                    child: Image.asset(
                      AppIcons.appLogo,
                      width: 145.w,
                      height: 144.h,
                    ),
                  ),
                  CustomSpacers.height60,
                  Text(
                    "Login with email",
                    style:
                        TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "Email",
                    controller: _emailController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "password",
                    controller: _passwordController,
                    type: TextInputType.emailAddress,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height20,
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 17.w,
                        fontWeight: FontWeight.w500),
                  ),
                  CustomSpacers.height20,
                  !value.isLoading
                      ? CustomButton(
                          strButtonText: "Log In",
                          buttonAction: () {
                            if (_formKey1.currentState!.validate()) {
                              // Process data.
                              value.login(_emailController.text,
                                  _passwordController.text, context);
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
                  CustomSpacers.height16,
                  !value.isLoading
                      ? Center(
                          child: Text("Or",
                              style: TextStyle(
                                  fontSize: 20.w, fontWeight: FontWeight.w600)))
                      : Container(),
                  CustomSpacers.height16,
                  !value.isLoading
                      ? CustomButton(
                          strButtonText: "Login with Phone",
                          buttonAction: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginWithOtpScreen()));
                          },
                          dHeight: 69.h,
                          dWidth: 369.w,
                          bgColor: Colors.blue,
                          dCornerRadius: 12,
                        )
                      : Container(),
                  CustomSpacers.height20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Don\'t have an Account? ',
                        style: TextStyle(
                            fontSize: 17.w, fontWeight: FontWeight.w300),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        }, // Assuming onTap is a callback passed to the widget
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 17.w,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
