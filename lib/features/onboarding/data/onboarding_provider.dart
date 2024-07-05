import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/constants/value_constants.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/managers/shared_preference_manager.dart';
import 'package:vivasayi/features/nav_bar.dart';
import 'package:vivasayi/features/onboarding/screens/otp_page.dart';

class OnboardingProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _verificationId = "";
  String get verificationId => _verificationId;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signup(String phone, BuildContext context, String name,
      String email, String password) async {
    _isLoading = true;
    notifyListeners();
    String phoneNumber = "+91" + phone;

    // Check if the phone number already exists in Firestore
    var querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      OverlayManager.showToast(
          type: ToastType.Alert,
          msg: "Already have an account with this number !");

      _isLoading = false;
      notifyListeners();
    } else {
      // Phone number does not exist, proceed with sending OTP
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.toString());
          OverlayManager.showToast(
              type: ToastType.Error,
              msg: "Failed to verify your number : ${e.toString()}");
          _isLoading = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP Page

          _verificationId = verificationId;
          _isLoading = false;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPageLogin(
                verificationId: verificationId,
                email: email,
                name: name,
                phone: phone,
                password: password,
              ),
            ),
          );
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _isLoading = false;
          notifyListeners();
        },
      );
    }
  }

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  void signInWithOTP(
      List<TextEditingController> _otpController,
      String verificationId,
      String name,
      String email,
      String phone,
      String password) async {
    _isLoading = true;
    try {
      String smsCode =
          _otpController.map((controller) => controller.text).join();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      await _saveUserData(name, email, phone, password);
      SharedPreferencesManager.setBool("isLogin", true);
      _isLoading = false;
      _isSuccess = true;
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to sign in: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveUserData(
      String name, String email, String phone, String password) async {
    try {
      await _firestore.collection('users').add({
        'id': phone,
        'name': name,
        'email': email,
        'phoneNumber': "+91" + phone,
        'password':
            password, // Note: Passwords should be hashed and not saved in plain text
        'createdAt': FieldValue.serverTimestamp(),
      });
      SharedPreferencesManager.setString("name", name);
      SharedPreferencesManager.setString("phone", phone);
      SharedPreferencesManager.setString("email", email);
    } catch (e) {
      print('Error saving user data: $e');
      // Handle error (show error message to the user)
      OverlayManager.showToast(type: ToastType.Alert, msg: e.toString());
    }
  }

  // ============void login with password ===================

  void login(String email, String password, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    String _email = email.trim();
    String _password = password.trim();

    try {
      // Check if user exists with email/phone number
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isEmpty) {
        OverlayManager.showToast(
            type: ToastType.Alert, msg: "User not exist !");
        _isLoading = false;
        notifyListeners();
      } else {
        // Assuming you store emailOrPhone and password in the Firestore
        var userDoc = userSnapshot.docs.first;
        String storedPassword = userDoc['password']; // Get the stored password

        if (storedPassword == password) {
          // Password matches, navigate to OTP Page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const NavBarScreen(),
            ),
          );
          _isLoading = false;
          notifyListeners();
        } else {
          Fluttertoast.showToast(msg: "Incorrect password");

          _isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.toString()}");

      _isLoading = false;
      notifyListeners();
    }
  }

  //============login with otp ===================

  bool _isOtp = false;
  bool get isOtp => _isOtp;

  String _vid = "";
  String get vid => _vid;
  void loginwithOTP(BuildContext context, String phone) async {
    _isLoading = true;
    notifyListeners();
    String phoneNumber = "+91" + phone;
    print(phoneNumber);
    // Check if the phone number already exists in Firestore
    var querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      OverlayManager.showToast(
          type: ToastType.Alert, msg: "User with this number does not exist!");

      _isLoading = false;
      notifyListeners();
    } else {
      // Phone number does not exist, proceed with sending OTP
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval or instant verification
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.toString());
          OverlayManager.showToast(
              type: ToastType.Error,
              msg: "Failed to verify your number : ${e.toString()}");
          _isLoading = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP Page

          _vid = verificationId;
          _isLoading = false;
          _isOtp = true;

          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _isLoading = false;
          notifyListeners();
        },
      );
    }
  }

  void veriy(String vid, List<TextEditingController> _otpController,
      BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      String smsCode =
          _otpController.map((controller) => controller.text).join();

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: vid,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);

      SharedPreferencesManager.setBool("isLogin", true);
      _isLoading = false;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NavBarScreen()));
      notifyListeners();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to sign in: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );

      _isLoading = false;
      notifyListeners();
    }
  }
}
