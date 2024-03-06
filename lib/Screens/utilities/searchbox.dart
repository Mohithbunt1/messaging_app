import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messaging_app/Screens/MainScreen/chatroom.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.8),
        flexibleSpace: const FlexibleSpaceBar(),
        toolbarHeight: 80,
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(hintText: 'Search here'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.withOpacity(0.8), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: Text("No users found"));
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final userData = users[index].data() as Map<String, dynamic>;
                final userId = users[index].id;
                final firstName = userData['FirstName'] ?? '';
                final lastName = userData['LastName'] ?? '';
                final phoneNumber = userData['Phone number'] ?? '';
                final image = userData['ImageUrl'] ?? '';

                final number = userData['PhoneNumber'] ?? '';

                if (firstName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    lastName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()) ||
                    phoneNumber.contains(searchController.text.toLowerCase())) {
                  return GestureDetector(
                    onTap: () {
                      final senderId = FirebaseAuth.instance.currentUser;
                      final receiverId = userId;

                      if (receiverId != null) {
                        final chatRoomId = senderId!.uid + receiverId;
                        FirebaseFirestore.instance
                            .collection("chat_rooms")
                            .doc(chatRoomId)
                            .set({
                          "participants": [senderId.uid, receiverId],
                          "time": DateTime.now()
                        }).then((_) {
                          Get.to(
                            ChatRoomScreen(
                              receiverId: receiverId,
                              chatroomid: chatRoomId,
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ChatRoomScreen(
                          //       receiverId: receiverId,
                          //       chatroomid: chatRoomId,
                          //     ),
                          //   ),
                          //  );
                        });
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(firstName),
                        leading: CircleAvatar(
                          backgroundImage:
                              image.isNotEmpty ? NetworkImage(image) : null,
                        ),
                        subtitle: Text(number),
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
      ),
    );
  }
}
