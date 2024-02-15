import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messaging_app/Screens/CustomizedWidget/textfield.dart';
import 'package:messaging_app/Screens/MainScreen/homepage.dart';

class EditPage extends StatefulWidget {
  EditPage({Key? key, required this.number});

  final number;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController bio = TextEditingController();
  File? image;

  Future<void> _getCameraImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      setState(() {
        image = imageTemp;
      });
    } catch (e) {
      print('Error picking/uploading image from camera: $e');
    }
  }

  Future<void> _getGalleryImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      final imageGal = File(pickedFile.path);
      setState(() {
        image = imageGal;
      });
    } catch (e) {
      print('Error picking/uploading image from gallery: $e');
    }
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    try {
      final filename = "${DateTime.now().millisecondsSinceEpoch}.jpeg";
      final Reference storageRef =
          FirebaseStorage.instance.ref().child("Images/$filename");
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image to storage: $e');
      return "";
    }
  }

  Future<void> _submitForm() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (firstname.text.isNotEmpty &&
          lastname.text.isNotEmpty &&
          age.text.isNotEmpty) {
        try {
          String imageUrl = "";
          if (image != null) {
            imageUrl = await _uploadImageToStorage(image!);
          }
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .set(
            {
              "FirstName": firstname.text,
              "LastName": lastname.text,
              "Age": age.text,
              "Bio": bio.text,
              "PhoneNumber": widget.number,
              "Date": DateTime.now(),
              "ImageUrl": imageUrl,
            },
            SetOptions(merge: true),
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Profile updated successfully"),
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                url: imageUrl,
                number: widget.number,
              ),
            ),
          );
          firstname.clear();
          lastname.clear();
          age.clear();
          bio.clear();
        } catch (e) {
          print('Error updating profile: $e');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Failed to update profile. Please try again."),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please fill all required fields"),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Data/account already exists, try to sign in"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit prfile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.withOpacity(0.8), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Chit_Chat Welcomes you",
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                "As a new user please fill the fields below",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: image != null ? FileImage(image!) : null,
                    radius: 100,
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "Select from",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 150,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: _getCameraImage,
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            size: 50,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: _getGalleryImage,
                                          icon: const Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: firstname,
                hintText: "First Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: lastname,
                hintText: "Last Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: age,
                hintText: "Enter your age",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: bio,
                hintText: "bio",
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
