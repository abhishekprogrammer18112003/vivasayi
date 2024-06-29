import 'package:flutter/material.dart';
import 'package:vivasayi/components/textfield.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/onboarding/otp_page.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpPageLogin(),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSpacers.height56,
                Center(
                  child: Image.asset(
                    AppIcons.app_logo,
                    width: 145.w,
                    height: 144.h,
                  ),
                ),
                CustomSpacers.height21,
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
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
                      onTap: widget
                          .onTap, // Assuming onTap is a callback passed to the widget
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
                CustomButton(
                  strButtonText: "Create Account",
                  buttonAction: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        OverlayManager.showToast(
                            type: ToastType.Alert,
                            msg: "Password must be same");
                      }
                    }
                  },
                  dHeight: 69.h,
                  dWidth: 369.w,
                  bgColor: Colors.green,
                  dCornerRadius: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
