import 'package:flutter/material.dart';
import 'package:vivasayi/components/textfield.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/onboarding/otp_page.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailphoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpPageLogin(),
      ),
    );
  }

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 56.h),
                Center(
                  child: Image.asset(
                    AppIcons.app_logo,
                    width: 145.w,
                    height: 144.h,
                  ),
                ),
                CustomSpacers.height60,
                Text(
                  "Login",
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                CustomSpacers.height26,
                MyTextfield(
                  labelText: "Email/Phone Number",
                  controller: _emailphoneController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please Enter email/phone number";
                    }
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
                CustomButton(
                  strButtonText: "Log In",
                  buttonAction: () {
                    if (_formKey1.currentState!.validate()) {
                      // Process data.
                      login();
                    }
                  },
                  dHeight: 69.h,
                  dWidth: 369.w,
                  bgColor: Colors.green,
                  dCornerRadius: 20,
                ),
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
                      onTap: widget
                          .onTap, // Assuming onTap is a callback passed to the widget
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
    );
  }
}
