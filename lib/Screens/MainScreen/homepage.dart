import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/Screens/LoginScreen/SignIn.dart';
import 'package:messaging_app/Screens/MainScreen/chatroom.dart';
import 'package:messaging_app/Screens/utilities/detailsPage.dart';
import 'package:messaging_app/Screens/utilities/searchbox.dart';
import 'package:messaging_app/Screens/widgets/Logout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.url, required this.number});

  final String? url;
  final String? number;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<DocumentSnapshot> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserData();
  }

  Future<DocumentSnapshot> _getUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        return await FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser.uid)
            .get();
      }
      throw Exception('User not authenticated');
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

  Future<void> _createChatRoom(String userId) async {
    try {
      final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserUid != null) {
        final chatRoomId = currentUserUid + userId;
        final chatRoomRef =
            FirebaseFirestore.instance.collection("chat_rooms").doc(chatRoomId);
        final chatRoomSnapshot = await chatRoomRef.get();

        if (!chatRoomSnapshot.exists) {
          await chatRoomRef.set({
            "participants": [currentUserUid, userId],
          });
        }
        Get.to(
          ChatRoomScreen(
            receiverId: userId,
            chatroomid: chatRoomId,
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ChatRoomScreen(
        //       receiverId: userId,
        //       chatroomid: chatRoomId,
        //     ),
        //   ),
        // );
      } else {
        throw Exception('Current user not found');
      }
    } catch (e) {
      print("Error creating chat room: $e");
      Get.snackbar("HEy there", "Failed to create chat room");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Failed to create chat room"),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.8),
        title: Text(
          "Chit_Chat",
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SearchBox());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SearchBox(),
              //   ),
              // );
            },
            icon: const Icon(Icons.person_search_sharp),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.withOpacity(0.8), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "Chit_Chat",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 34),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FutureBuilder<DocumentSnapshot>(
                  future: _getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text("No data found");
                    } else {
                      final data = snapshot.data!;
                      final imageUrl = widget.url;
                      final number = widget.number;

                      if (imageUrl == null || imageUrl.isEmpty) {
                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 100,
                              child: Icon(Icons.person),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(EditPage(number: number));
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         EditPage(number: number),
                                //   ),
                                // );
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(
                                EditPage(number: number),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         EditPage(number: number),
                              //   ),
                              // );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Username -${data["FirstName"]}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Age -${data["Age"]}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "PhoneNumber -${data["PhoneNumber"]}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Bio -${data["Bio"]}",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          const Divider(
                            color: Color(0xAA884490),
                            thickness: 5,
                            endIndent: 10,
                            height: 10,
                            indent: 10,
                          ),
                        ],
                      );
                    }
                  },
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: const Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                    ],
                  ),
                ),
                const Divider(
                    color: Color(0xAA884490),
                    thickness: 2,
                    endIndent: 5,
                    height: 0.1,
                    indent: 5),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.to(SignInPage());

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SignInPage(),
                      //     ));
                    },
                    child: const Logout(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Privacy and Policy",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "About us",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No users found"));
          }
          final users = snapshot.data!.docs;
          final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data();
              final userId = users[index].id;
              final firstName = userData['FirstName'] ?? '';
              final image = userData['ImageUrl'] ?? '';
              final number = userData['PhoneNumber'] ?? '';
              if (userId != currentUserUid) {
                return GestureDetector(
                  onTap: () async {
                    await _createChatRoom(userId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
                    child: Card(
                      shape: const ContinuousRectangleBorder(),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              image.isNotEmpty ? NetworkImage(image) : null,
                        ),
                        title: Text(
                          firstName,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(number),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        },
      ),
    );
  }
}
