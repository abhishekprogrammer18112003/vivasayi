import 'package:flutter/material.dart';
import 'package:vivasayi/features/login_signup/login.dart';
import 'package:vivasayi/features/login_signup/signup.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => __LoginOrSignUpState();
}

// ignore: camel_case_types
class __LoginOrSignUpState extends State<LoginOrSignUp> {
  bool show_login = true;

  void toogle() {
    setState(() {
      show_login = !show_login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (show_login) {
      return Login(
        onTap: toogle,
      );
    } else {
      return SignUp(
        onTap: toogle,
      );
    }
  }
}
