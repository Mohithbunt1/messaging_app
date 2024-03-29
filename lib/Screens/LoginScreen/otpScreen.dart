import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/Screens/LoginScreen/Welcome.dart';
import 'package:messaging_app/Screens/MainScreen/homepage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpAuth extends StatefulWidget {
  const OtpAuth(
      {super.key, required this.verificationId, required this.number});
  final verificationId;
  final number;

  @override
  State<OtpAuth> createState() => _OtpAuthState();
}

class _OtpAuthState extends State<OtpAuth> {
  var otpcontroller = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    print(
        "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>###########3()()()()()()()()()()()${widget.number}");
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green.withOpacity(0.8), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 250),
              const Text(
                "AUTHENTICATION",
                style: TextStyle(),
              ),
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                  ),
                  textGradient: LinearGradient(
                      colors: [Colors.green.shade600, Colors.green.shade100],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  textStyle: const TextStyle(fontSize: 20, height: 1.6),
                  controller: otpcontroller,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              // ElevatedButton(
              //   style: ButtonStyle(
              //       backgroundColor:
              //           MaterialStatePropertyAll(Colors.green.shade500)),
              //   onPressed: () async {
              //     try {
              //       PhoneAuthCredential cred =
              //           await PhoneAuthProvider.credential(
              //         verificationId: widget.verificationId,
              //         smsCode: otpcontroller.text.toString(),
              //       );
              //       await FirebaseAuth.instance
              //           .signInWithCredential(cred)
              //           .then((value) {
              //         final User? user = FirebaseAuth.instance.currentUser;
              //         final uid = user!.uid;
              //         var currentuser = FirebaseFirestore.instance
              //             .collection("users")
              //             .doc(uid)
              //             .get();
              //             if(currentuser.exists){};
              //       });
              //       Navigator.pushReplacement(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => HomeScreen(),
              //         ),
              //       );
              //     } on FirebaseAuthException catch (e) {
              //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //           content: Text("Something went wrong/ ${e.message}")));
              //     }
              //   },
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.green.shade500),
                ),
                onPressed: () async {
                  setState(() {
                    isloading = false;
                  });
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.setBool('statuslog', true);
                  try {
                    print(
                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.verificationId}");
                    print(
                        ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.number}");

                    PhoneAuthCredential cred = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: otpcontroller.text.toString(),
                    );

                    await FirebaseAuth.instance
                        .signInWithCredential(cred)
                        .then((value) async {
                      final User? user = FirebaseAuth.instance.currentUser;
                      final uid = user!.uid;
                      var currentuser = await FirebaseFirestore.instance
                          .collection("users")
                          .doc(uid)
                          .get();

                      if (currentuser.exists) {
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.verificationId}");
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.number}");
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${currentuser}");
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${user}");
                        Get.to(HomeScreen(
                          number: widget.number,
                          url: user.photoURL,
                        ));

                        print(
                            "checking if the number passes>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>LCdkjushgv?>>>>>>${widget.number}");
                      } else {
                        Get.to(
                          WelcomeScreen(
                            number: widget.number,
                          ),
                        );
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => WelcomeScreen(
                        //       number: widget.number,
                        //     ),
                        //   ),
                        // );
                        print(
                            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.verificationId}");
                        print(
                            "cheking for welcome number>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${widget.number}");
                      }
                    });
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Something went wrong: ${e.message}"),
                    ));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Color.fromARGB(255, 124, 78, 78),
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
