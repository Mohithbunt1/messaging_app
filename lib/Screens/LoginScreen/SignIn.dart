import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpAuth(
                    verificationId: verifyId,
                    number: phoneController.text,
                  ),
                ),
              );
              print(
                  ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^>>>>${phoneController.text}");
            },
            codeAutoRetrievalTimeout: (String verifId) {},
            phoneNumber: "+91${phoneController.text}");
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${e.message}",
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 2,
          width: MediaQuery.of(context).size.width * 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.withOpacity(0.8), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
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
              const SizedBox(height: 200),
              const CircleAvatar(
                  radius: 130,
                  backgroundImage: NetworkImage(
                      // "https://t4.ftcdn.net/jpg/01/34/65/09/240_F_134650964_bwxkr6J1hKrVOgmmz6fxvxPvuGW2vy3N.jpg",
                      "https://img.freepik.com/free-vector/hello-comic-style_53876-26585.jpg?w=740&t=st=1707461694~exp=1707462294~hmac=80c21dfff96e12f61b84a05e09a18b5542be27f10f7d0af917b7c98af33d43a6"),
                  foregroundColor: Colors.green),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "L O G I N",
                  style: TextStyle(
                      color: Colors.green[900],
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
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.green[300],
                      filled: true,
                      hintText: "Enter your number",
                      hintStyle: const TextStyle(color: Colors.white),
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
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.green.shade500)),
                onPressed: onsubmitted,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "SignIn",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GLoginPage(number: phoneController.text),
            ],
          ),
        ),
      ),
    );
  }
}
