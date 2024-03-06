import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_app/Screens/MainScreen/chatroom.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({Key? key}) : super(key: key);

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? doc;
  String docUrl = "";
  File? imageFile;
  String imageUrl = "";
  String aadhar = "";
  File? imageAadhar;

  Future getImageCamera() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("images/$fileName");
      await imageRef.putFile(imageTemp);
      final imageUrl = await imageRef.getDownloadURL();
      setState(() {
        imageFile = imageTemp;
        this.imageUrl = imageUrl;
      });
    } catch (e) {
      print('Error picking/uploading image from camera: $e');
    }
  }

  Future pickAadharImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("images/$fileName");
      await imageRef.putFile(imageTemp);
      final imageUrl = await imageRef.getDownloadURL();
      setState(() {
        imageAadhar = imageTemp;
        aadhar = imageUrl;
      });
    } catch (e) {
      print('Error picking/uploading image from gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set Your Profile Picture",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            if (imageUrl.isNotEmpty)
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            FilledButton(
              onPressed: getImageCamera,
              child: const Text("Open Camera"),
            ),
            const SizedBox(height: 50),
            if (aadhar.isNotEmpty)
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: ClipOval(
                  child: Image.network(
                    aadhar,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            FilledButton(
              onPressed: pickAadharImage,
              child: const Text("Open Gallery"),
            ),
            const SizedBox(height: 40),
            FilledButton(
              onPressed: () async {
                final userdata = FirebaseAuth.instance.currentUser;

                if (aadhar.isNotEmpty || imageUrl.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatRoomScreen(
                              imageurl: imageUrl.isNotEmpty ? imageUrl : aadhar,
                            )),
                  );
                }
              },
              child: const Text("Add Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
