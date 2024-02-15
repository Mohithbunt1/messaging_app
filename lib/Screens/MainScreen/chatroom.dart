import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, this.data, this.chatroomid});
  final data;
  final chatroomid;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(),
        ),
        title: const Text(
          "Chatroom",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.green.withOpacity(0.8),
        elevation: 0,
        // Text(widget.data["FirstName"]),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.green.withOpacity(0.8), Colors.white38],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chat_rooms")
                    .doc(widget.chatroomid)
                    .collection("messages")
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No messages yet"),
                    );
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(
                          message["text"],
                        ),
                        subtitle: Text(
                          message["senderId"],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 85,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.black38),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Type here",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send, size: 33),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
