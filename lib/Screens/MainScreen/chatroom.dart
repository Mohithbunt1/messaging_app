import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   const ChatRoomScreen({
//     Key? key,
//     this.data,
//     this.chatroomid,
//     required this.reciverId,
//   }) : super(key: key);

//   final data;

//   final chatroomid;
//   final reciverId;

//   @override
//   State<ChatRoomScreen> createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final textController = TextEditingController();

//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Padding(
//           padding: EdgeInsets.only(left: 10),
//           child: CircleAvatar(),
//         ),
//         title: Text(
//           widget.reciverId,
//           style: const TextStyle(color: Colors.white, fontSize: 30),
//         ),
//         backgroundColor: Colors.green.withOpacity(0.8),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.green.withOpacity(0.8), Colors.white38],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection("chat_rooms")
//                     .doc(widget.chatroomid)
//                     .collection("messages")
//                     .orderBy("timestamp", descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   final messages = snapshot.data!.docs;
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index].data();
//                       final isSentByCurrentUser = message["senderId"] ==
//                           FirebaseAuth.instance.currentUser!.uid;

//                       return ListTile(
//                         title: Text(message["text"]),
//                         subtitle: Text(
//                             isSentByCurrentUser ? "You" : widget.reciverId),
//                         trailing:
//                             isSentByCurrentUser ? null : Icon(Icons.person),
//                         leading:
//                             isSentByCurrentUser ? Icon(Icons.person) : null,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Container(
//               color: Colors.transparent,
//               height: 85,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: textController,
//                         decoration: const InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               style: BorderStyle.solid,
//                               color: Colors.black38,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               style: BorderStyle.solid,
//                               color: Colors.black38,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               style: BorderStyle.solid,
//                               color: Colors.black38,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//                           hintText: "Type here",
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () async {
//                         if (textController.text.isNotEmpty) {
//                           try {
//                             await FirebaseFirestore.instance
//                                 .collection("chat_rooms")
//                                 .doc(widget.chatroomid)
//                                 .collection("messages")
//                                 .add({
//                               "text": textController.text,
//                               "senderId":
//                                   FirebaseAuth.instance.currentUser!.uid,
//                               "receiverId": widget.reciverId,
//                               "timestamp": DateTime.now(),
//                             });
//                             textController.clear();
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text("Failed to send message: $e"),
//                               ),
//                             );
//                           }
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Please enter a message"),
//                             ),
//                           );
//                         }
//                       },
//                       icon: const Icon(Icons.send, size: 33),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    this.data,
    required this.chatroomid,
    required this.receiverId,
  }) : super(key: key);

  final data;
  final String chatroomid;
  final String receiverId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  late String receiverName;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchReceiverName();
  }

  Future<void> fetchReceiverName() async {
    try {
      final receiverDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.receiverId)
          .get();
      if (receiverDoc.exists) {
        setState(() {
          receiverName = receiverDoc["FirstName"] ??
              ""; // Replace "FirstName" with the correct field name
        });
      } else {
        print("Receiver document does not exist");
      }
    } catch (e) {
      print("Error fetching receiver's name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(),
        ),
        title: Text(
          receiverName ?? "", // Display receiver's name in the app bar title
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.green.withOpacity(0.8),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.withOpacity(0.8), Colors.white38],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index].data();
                      final isSentByCurrentUser = message["senderId"] ==
                          FirebaseAuth.instance.currentUser!.uid;

                      return ListTile(
                        title: Text(message["text"]),
                        subtitle: Text(
                            isSentByCurrentUser ? "You" : widget.receiverId),
                        trailing:
                            isSentByCurrentUser ? null : Icon(Icons.person),
                        leading:
                            isSentByCurrentUser ? Icon(Icons.person) : null,
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
                        controller: textController,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: "Type here",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (textController.text.isNotEmpty) {
                          try {
                            await FirebaseFirestore.instance
                                .collection("chat_rooms")
                                .doc(widget.chatroomid)
                                .collection("messages")
                                .add({
                              "text": textController.text,
                              "senderId":
                                  FirebaseAuth.instance.currentUser!.uid,
                              "receiverId": widget.receiverId,
                              "timestamp": DateTime.now(),
                            });
                            textController.clear();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Failed to send message: $e"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please enter a message"),
                            ),
                          );
                        }
                      },
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
