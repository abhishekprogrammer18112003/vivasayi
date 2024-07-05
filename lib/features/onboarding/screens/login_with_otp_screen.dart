import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/constants/app_icons.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/onboarding/data/onboarding_provider.dart';
import 'package:vivasayi/features/onboarding/screens/login.dart';
import 'package:vivasayi/features/onboarding/screens/signup.dart';
import 'package:vivasayi/features/onboarding/widgets/my_text_field.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class LoginWithOtpScreen extends StatefulWidget {
  const LoginWithOtpScreen({super.key});

  @override
  State<LoginWithOtpScreen> createState() => _LoginWithOtpScreenState();
}

class _LoginWithOtpScreenState extends State<LoginWithOtpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpController = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Form(
            key: _formKey2,
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
                    "Login with phone",
                    style:
                        TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  CustomSpacers.height26,
                  MyTextfield(
                    labelText: "phone number",
                    controller: _phoneController,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter phone number";
                      }
                      return null;
                    },
                  ),
                  CustomSpacers.height30,
                  value.isOtp
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => SizedBox(
                              width: 58.w,
                              height: 43.h,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.h,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextField(
                                      controller: _otpController[index],
                                      decoration: const InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize:
                                                20), // Adjust font size of hint text
                                        counterText: '',
                                        border: InputBorder.none,
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: const TextStyle(
                                          fontSize:
                                              22), // Adjust font size of entered digits
                                      onChanged: (value) {
                                        if (value.length == 1 && index < 7) {
                                          // Move focus to the next OTP input box
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  CustomSpacers.height26,
                  CustomSpacers.height20,
                  CustomSpacers.height20,
                  !value.isLoading
                      ? CustomButton(
                          strButtonText: !value.isOtp ? "Login" : "verify",
                          buttonAction: () {
                            if (_formKey2.currentState!.validate()) {
                              // Process data.
                              !value.isOtp
                                  ? value.loginwithOTP(
                                      context, _phoneController.text)
                                  : value.veriy(
                                      value.vid, _otpController, context);
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
                          strButtonText: "Login with email",
                          buttonAction: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
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
