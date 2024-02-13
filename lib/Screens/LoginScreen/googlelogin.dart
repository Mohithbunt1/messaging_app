import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messaging_app/Screens/LoginScreen/Welcome.dart';
import 'package:messaging_app/Screens/MainScreen/homepage.dart';

class GLoginPage extends StatefulWidget {
  const GLoginPage({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  State<GLoginPage> createState() => _GLoginPageState();
}

class _GLoginPageState extends State<GLoginPage> {
  TextEditingController emailc = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future<void> Authservice() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userCredential != null) {
      final user = userCredential.user;
      if (user != null) {
        final userExists = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((doc) => doc.exists);

        if (userExists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      url: '',
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => WelcomeScreen(number: widget.number)),
          );
        }
      }
    }
  }

  bool password = true;
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  String _error = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: const ButtonStyle(
            iconColor: MaterialStatePropertyAll(
              Colors.red,
            ),
            shape: MaterialStatePropertyAll(
              CircleBorder(),
            ),
          ),
          onPressed: () {
            Authservice();
          },
          child: const Padding(
            padding: EdgeInsets.all(13.0),
            child: Icon(
              Icons.g_mobiledata,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}
