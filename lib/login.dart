import 'package:clone/home_page.dart';
import 'package:clone/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final pagecontroller = PageController(initialPage: 0);

  final TextEditingController phoneController = TextEditingController();
  String? _otp;
  String? verId;

  bool isLoading = false;

  String? _phone;

  Future<void> verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationId, int? resendToken) {
          verId = verificationId;
          pagecontroller.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: "+91 ${phoneController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: pagecontroller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          getPhoneNumber(),
          veryOTP(),
        ],
      ),
    );
  }

  Widget getPhoneNumber() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Hey, there!",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),

                TextFormField(
                  controller: phoneController,
                  maxLength: 10,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: const TextStyle(
                      color: Colors.black45,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Optional: customize focused border
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: const BorderSide(
                        color: Colors
                            .black, // Change this to your desired color for focus
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phone = value!;
                  },
                ),

                const SizedBox(height: 16),

                const SizedBox(height: 16), // Add some space between fields
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () async {
                      if (phoneController.text.length != 10) {
                        return;
                      } else {
                        verifyPhone();
                        pagecontroller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      }
                    },
                    child: const Text(
                      'Generate OTP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ), // Add some space between button and text field
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget veryOTP() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              pagecontroller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Verify your OTP",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: const Color(0xFF424242),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (value) {
                      _otp = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () async {
                        if (_otp == null || _otp!.length != 6) {
                          return;
                        }

                        setState(() {
                          isLoading = !isLoading;
                        });

                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verId!, smsCode: _otp!);

                          await FirebaseAuth.instance
                              .signInWithCredential(credential);

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } catch (e) {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          showMessage("Incorrect OTP");
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      },
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              'No OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                    ),
                  ), // Add some space between button and text field
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
