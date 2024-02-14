import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, this.data});
  final data;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(77, 255, 157, 255),
      appBar: PreferredSize(
        preferredSize: Size(0, 100),
        child: Center(
          child: Text(
            "Hey THERE",
          ),
        ),
      ),
    );
  }
}
