import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/Screens/LoginScreen/googlelogin.dart';
import 'package:messaging_app/Screens/LoginScreen/otpScreen.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();

    void onsubmitted() async {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
            verificationCompleted: (PhoneAuthCredential Cred) {},
            verificationFailed: (FirebaseAuthException e) {},
            codeSent: (String verifyId, int? resendotp) {
              Get.to(
                OtpAuth(
                  verificationId: verifyId,
                  number: phoneController.text,
                ),
              );
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => OtpAuth(
              //       verificationId: verifyId,
              //       number: phoneController.text,
              //     ),
              //   ),
              // );
              print(
                  ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${phoneController.text}");
            },
            codeAutoRetrievalTimeout: (String verifId) {},
            phoneNumber: "+91${phoneController.text}");
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       "${e.message}",
        //     ),
        //   ),
        // );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(height: 20, decoration: BoxDecoration(color: Colors.white)),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                width: MediaQuery.of(context).size.width * 1,

                decoration: BoxDecoration(color: Color.fromARGB(255, 4, 0, 48)
                    // gradient: LinearGradient(
                    //     colors: [Color.fromARGB(255, 3, 0, 34), Colors.white10],
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter),
                    ),
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     opacity: 0.8,
                //     image: NetworkImage(
                //       "https://img.freepik.com/free-vector/stream-binary-code-design-vector_53876-170622.jpg?w=360&t=st=1707403816~exp=1707404416~hmac=ba57cfb4c5c0b9724633e78b36a477f120c1bb15c65225ff0a8edfe1b5eea51c",
                //     ),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const CircleAvatar(
                        radius: 130,
                        backgroundColor: Color.fromARGB(255, 4, 0, 48),
                        backgroundImage: NetworkImage(
                            "https://wallpaperaccess.com/full/3622496.jpg"
                            // "https://t4.ftcdn.net/jpg/01/34/65/09/240_F_134650964_bwxkr6J1hKrVOgmmz6fxvxPvuGW2vy3N.jpg",
                            // "https://img.freepik.com/free-vector/hello-comic-style_53876-26585.jpg?w=740&t=st=1707461694~exp=1707462294~hmac=80c21dfff96e12f61b84a05e09a18b5542be27f10f7d0af917b7c98af33d43a6",
                            ),
                        foregroundColor: Colors.white),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "L O G I N",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: 400,
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 22),
                          controller: phoneController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Enter your number",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 4, 0, 48)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Container(
                    //     width: 400,
                    //     child: TextField(
                    //       style: const TextStyle(color: Colors.white, fontSize: 22),
                    //       controller: passController,
                    //       keyboardType: TextInputType.visiblePassword,
                    //       obscureText: true,
                    //       decoration: InputDecoration(
                    //         border: OutlineInputBorder(
                    //           borderSide: BorderSide.none,
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         fillColor: Colors.green[300],
                    //         filled: true,
                    //         hintText: "Enter your password",
                    //         hintStyle: const TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(8, 8)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white)),
                      onPressed: onsubmitted,
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "SignIn",
                          style: TextStyle(
                            color: Color.fromARGB(255, 4, 0, 48),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text("or", style: TextStyle(color: Colors.white)),
                    SizedBox(
                      height: 40,
                    ),
                    GLoginPage(number: phoneController.text),
                  ],
                ),
              ),
            ),
          ),
          Container(
              height: 100, decoration: BoxDecoration(color: Colors.white)),
        ]),
      ),
    );
  }
}
