import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/onboarding/data/onboarding_provider.dart';
import 'package:vivasayi/features/onboarding/screens/login.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';

class OtpPageLogin extends StatefulWidget {
  String verificationId;
  String name;
  String email, password, phone;
  OtpPageLogin(
      {super.key,
      required this.verificationId,
      required this.name,
      required this.email,
      required this.phone,
      required this.password});

  @override
  State<OtpPageLogin> createState() => _OtpPageLoginState();
}

class _OtpPageLoginState extends State<OtpPageLogin> {
  final List<TextEditingController> _otpController = List.generate(
    6,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Consumer<OnboardingProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            !value.isSuccess ? _buildbody() : _buildBodySuccess(),
            CustomSpacers.height70,
            !value.isLoading
                ? CustomButton(
                    strButtonText: value.isSuccess ? "Verify" : "Continue",
                    buttonAction: () {
                      if (!value.isSuccess) {
                        FocusScope.of(context).unfocus();
                        value.signInWithOTP(
                            _otpController,
                            widget.verificationId,
                            widget.name,
                            widget.email,
                            widget.phone,
                            widget.password);
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
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
          ],
        ),
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
              6,
              (index) => SizedBox(
                width: 58.w,
                height: 43.h,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
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
                        controller: _otpController[index],
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
                color: const Color.fromARGB(255, 0, 0, 0),
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
