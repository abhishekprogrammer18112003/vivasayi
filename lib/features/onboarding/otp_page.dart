import 'package:flutter/material.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class OtpPageLogin extends StatefulWidget {
  const OtpPageLogin({super.key});

  @override
  State<OtpPageLogin> createState() => _OtpPageLoginState();
}

class _OtpPageLoginState extends State<OtpPageLogin> {
  bool _isSuccess = false;
  void verify() {
    print("helo");
    setState(() {
      _isSuccess = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          !_isSuccess ? _buildbody() : _buildBodySuccess(),
          CustomSpacers.height70,
          CustomButton(
            strButtonText: !_isSuccess ? "Verify" : "Continue",
            buttonAction: () {
              verify();
            },
            dHeight: 69.h,
            dWidth: 369.w,
            bgColor: Colors.green,
            dCornerRadius: 20,
          ),
        ],
      ),
    );
  }

  _buildbody() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSpacers.height56,
          Center(
            child: Image.asset(
              'assets/vivasayi_logo.png',
              width: 145.w,
              height: 144.h,
            ),
          ),
          // SizedBox(height: 64.h),
          CustomSpacers.height64,

          Text(
            "Enter OTP",
            style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w600),
          ),
          CustomSpacers.height12,
          Text(
            "Send the OTP to the given phone number and check it.",
            style: TextStyle(fontSize: 14.w, fontWeight: FontWeight.w400),
          ),

          SizedBox(height: 29.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => SizedBox(
                width: 68.w,
                height: 43.h,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.h, color: const Color.fromARGB(255, 0, 0, 0)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
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
          ),

          CustomSpacers.height40,
          const Row(
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
          CustomSpacers.height20,
          Text(
            'Resend Code',
            style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w400,
                color: Colors.green),
          ),
        ],
      );

  _buildBodySuccess() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomSpacers.height80,
          Text(
            'Success !',
            style: TextStyle(
                fontSize: 36.w,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600),
          ),
          CustomSpacers.height20,
          const Text(
            'Your account has been created',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500),
          ),
          CustomSpacers.height30,
          Center(
            child: Image.asset(
              'assets/check-mark 2.png',
              width: 300.w,
              height: 300.h,
            ),
          ),
        ],
      );
}
