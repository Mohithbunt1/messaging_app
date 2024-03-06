// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class ChatRoomScreen extends StatefulWidget {
// //   const ChatRoomScreen({
// //     Key? key,
// //     required this.chatroomid,
// //     required this.receiverId,
// //   }) : super(key: key);

// //   final String chatroomid;
// //   final String receiverId;

// //   @override
// //   State<ChatRoomScreen> createState() => _ChatRoomScreenState();
// // }

// // class _ChatRoomScreenState extends State<ChatRoomScreen> {
// //   final textController = TextEditingController();
// //   String receiverName = "";
// //   String image = "";
// //   bool isLoading = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchReceiverData();
// //   }
// //    String generateChatroomID(String uid1, String uid2) {
// //     final userIds = [uid1, uid2];
// //     userIds.sort();
// //     return userIds.join("_");
// //   }

// //   Future<void> fetchReceiverData() async {
// //     try {
// //       final receiverDoc = await FirebaseFirestore.instance
// //           .collection("users")
// //           .doc(widget.receiverId)
// //           .get();
// //       if (receiverDoc.exists) {
// //         setState(() {
// //           receiverName = receiverDoc["FirstName"] ?? "";
// //           image = receiverDoc["ImageUrl"] ?? "";
// //         });
// //       } else {
// //         print("Receiver document does not exist");
// //       }
// //     } catch (e) {
// //       print("Error fetching receiver's data: $e");
// //     }
// //     print(
// //         ">>>>>>>>>>)*))))))))))))))))))))))))))))))))((((((((((((((((((((((((((((((((((((>>>>>>>>>>>>>$fetchReceiverData()");
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: Padding(
// //           padding: const EdgeInsets.only(left: 10),
// //           child: image.isNotEmpty
// //               ? CircleAvatar(
// //                   backgroundImage: NetworkImage(image),
// //                 )
// //               : const Icon(Icons.person),
// //         ),
// //         title: Text(
// //           receiverName,
// //           style: const TextStyle(color: Colors.white, fontSize: 30),
// //         ),
// //         backgroundColor: Colors.green.withOpacity(0.8),
// //         elevation: 0,
// //       ),
// //       body: Column(
// //         children: [
// //           Expanded(
// //             child: StreamBuilder(
// //                 stream: FirebaseFirestore.instance
// //                     .collection("chat_rooms")
// //                     .doc(widget.chatroomid)
// //                     .collection("messages")
// //                     .orderBy("timestamp", descending: false)
// //                     .snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }
// //                   if (snapshot.hasError) {
// //                     return Text('Error: ${snapshot.error}');
// //                   }
// //                   // final messages = snapshot.data?.docs ?? [];
// //                   return ListView.builder(
// //                       itemCount: snapshot.data!.docs.length,
// //                       itemBuilder: (context, index) {
// //                         // final message = messages[index].data();
// //                         // final isCurrentUser = message["senderId"] ==
// //                         //     FirebaseAuth.instance.currentUser!.uid;
// //                         return Align(
// //                             alignment: snapshot.data!.docs[index]["senderId"] ==
// //                                     FirebaseAuth.instance.currentUser!.uid
// //                                 ? Alignment.centerRight
// //                                 : Alignment.centerLeft,
// //                             child: Container(
// //                               padding: const EdgeInsets.all(10),
// //                               margin: const EdgeInsets.symmetric(
// //                                   horizontal: 10, vertical: 10),
// //                               decoration: BoxDecoration(
// //                                 color: snapshot.data!.docs[index]["senderId"] ==
// //                                         FirebaseAuth.instance.currentUser!.uid
// //                                     ? Colors.blue[100]
// //                                     : Colors.grey[200],
// //                                 borderRadius:
// //                                     const BorderRadius.all(Radius.circular(10)),
// //                               ),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text(snapshot.data!.docs[index]["text"]),
// //                                   Text(
// //                                     snapshot.data!.docs[index]["senderId"] ==
// //                                             FirebaseAuth
// //                                                 .instance.currentUser!.uid
// //                                         ? 'You'
// //                                         : widget.receiverId,
// //                                     style: const TextStyle(
// //                                         fontSize: 12, color: Colors.black54),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ));
// //                       });
// //                   //   return ListView.builder(
// //                   //     itemCount: snapshot.data!.docs.length,
// //                   //     itemBuilder: (context, index) {
// //                   //       final message = snapshot.data!.docs[index].data();
// //                   //       final isCurrentUser = message["senderId"] ==
// //                   //           FirebaseAuth.instance.currentUser!.uid;
// //                   //       return Align(
// //                   //         alignment: isCurrentUser
// //                   //             ? Alignment.centerRight
// //                   //             : Alignment.centerLeft,
// //                   //         child: Container(
// //                   //           padding: const EdgeInsets.all(10),
// //                   //           margin: const EdgeInsets.symmetric(
// //                   //               horizontal: 10, vertical: 10),
// //                   //           decoration: BoxDecoration(
// //                   //             color: isCurrentUser
// //                   //                 ? Colors.blue[100]
// //                   //                 : Colors.grey[200],
// //                   //             borderRadius:
// //                   //                 const BorderRadius.all(Radius.circular(10)),
// //                   //           ),
// //                   //           child: Column(
// //                   //             crossAxisAlignment: CrossAxisAlignment.start,
// //                   //             children: [
// //                   //               Text(message["text"]),
// //                   //               Text(
// //                   //                 isCurrentUser ? "You" : receiverName,
// //                   //                 style: const TextStyle(
// //                   //                     fontSize: 12, color: Colors.black54),
// //                   //               ),
// //                   //             ],
// //                   //           ),
// //                   //         ),
// //                   //       );
// //                   //     },
// //                   //   );
// //                 }),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Container(
// //               child: Row(
// //                 children: [
// //                   Expanded(
// //                     child: TextField(
// //                       controller: textController,
// //                       decoration: const InputDecoration(
// //                         hintText: 'Type a message',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                     ),
// //                   ),
// //                   IconButton(
// //                     icon: const Icon(Icons.send),
// //                     onPressed: () async {
// //                       if (textController.text.isNotEmpty) {
// //                         await FirebaseFirestore.instance
// //                             .collection("chat_rooms")
// //                             .doc(widget.chatroomid)
// //                             .collection("messages")
// //                             .doc()
// //                             .set({
// //                           "text": textController.text,
// //                           "senderId": FirebaseAuth.instance.currentUser!.uid,
// //                           "timestamp": Timestamp.now(),
// //                           "reciverid": widget.receiverId
// //                         }).then((value) {
// //                           FirebaseFirestore.instance
// //                               .collection("chat_rooms")
// //                               .doc(widget.chatroomid)
// //                               .set({
// //                             "room": widget.chatroomid,
// //                             "time": DateTime.now()
// //                           });
// //                         });
// //                         textController.clear();
// //                       }
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ChatRoomScreen extends StatefulWidget {
//   const ChatRoomScreen({
//     Key? key,
//     this.receiverId,
//     this.chatroomid,
//     this.imageurl,
//   }) : super(key: key);

//   final receiverId;
//   final chatroomid;
//   final imageurl;

//   @override
//   State<ChatRoomScreen> createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final textController = TextEditingController();
//   String receiverName = "";
//   String image = "";
//   bool isLoading = true;

//   File? doc;
//   String docUrl = "";
//   File? imageFile;
//   String imageUrl = "";
//   String aadhar = "";
//   File? imageAadhar;

//   Future getImageCamera() async {
//     try {
//       final pickedFile =
//           await ImagePicker().pickImage(source: ImageSource.camera);
//       if (pickedFile == null) return;
//       final imageTemp = File(pickedFile.path);
//       final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
//       final storageRef = FirebaseStorage.instance.ref();
//       final imageRef = storageRef.child("images/$fileName");
//       await imageRef.putFile(imageTemp);
//       final imageUrl = await imageRef.getDownloadURL();
//       setState(() {
//         imageFile = imageTemp;
//         this.imageUrl = imageUrl;
//       });
//     } catch (e) {
//       print('Error picking/uploading image from camera: $e');
//     }
//   }

//   Future pickAadharImage() async {
//     try {
//       final pickedFile =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedFile == null) return;
//       final imageTemp = File(pickedFile.path);
//       final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
//       final storageRef = FirebaseStorage.instance.ref();
//       final imageRef = storageRef.child("images/$fileName");
//       await imageRef.putFile(imageTemp);
//       final imageUrl = await imageRef.getDownloadURL();
//       setState(() {
//         imageAadhar = imageTemp;
//         aadhar = imageUrl;
//       });
//     } catch (e) {
//       print('Error picking/uploading image from gallery: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchReceiverData();
//   }

//   Future<void> fetchReceiverData() async {
//     try {
//       final receiverDoc = await FirebaseFirestore.instance
//           .collection("users")
//           .doc(widget.receiverId)
//           .get();
//       if (receiverDoc.exists) {
//         setState(() {
//           receiverName = receiverDoc["FirstName"] ?? "";
//           image = receiverDoc["ImageUrl"] ?? "";
//         });
//       } else {
//         print("Receiver document does not exist");
//       }
//     } catch (e) {
//       print("Error fetching receiver's data: $e");
//     }
//   }

//   String generateChatroomID(String uid1, String uid2) {
//     final userIds = [uid1, uid2];
//     userIds.sort();
//     return userIds.join("_");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentUserID = FirebaseAuth.instance.currentUser!.uid;
//     final chatroomID = generateChatroomID(currentUserID, widget.receiverId);

//     return Scaffold(
//       appBar: AppBar(
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: image.isNotEmpty
//               ? CircleAvatar(
//                   backgroundImage: NetworkImage(image),
//                 )
//               : const Icon(Icons.person),
//         ),
//         title: Text(
//           receiverName,
//           style: const TextStyle(color: Colors.white, fontSize: 30),
//         ),
//         backgroundColor: Colors.green.withOpacity(0.8),
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("chat_rooms")
//                   .doc(chatroomID)
//                   .collection("messages")
//                   .orderBy("timestamp", descending: false)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 }
//                 return ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   itemBuilder: (context, index) {
//                     final message = snapshot.data!.docs[index].data();
//                     final isCurrentUser = message["senderId"] == currentUserID;

//                     return Align(
//                       alignment: isCurrentUser
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: isCurrentUser
//                               ? Colors.blue[100]
//                               : Colors.grey[200],
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(message.isNotEmpty
//                                 ? message["text"]
//                                 : Container(
//                                     height: 200,
//                                     width: 150,
//                                     child: message["chatimage"],
//                                   )),
//                             Text(
//                               isCurrentUser ? "You" : receiverName,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: IconButton(
//                       onPressed: () {
//                         showModalBottomSheet(
//                           context: context,
//                           builder: (context) {
//                             return Column(
//                               children: [
//                                 const Padding(
//                                   padding: EdgeInsets.all(15.0),
//                                   child: Text(
//                                     "Select from",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       fontSize: 26,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 150,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       IconButton(
//                                         onPressed: getImageCamera,
//                                         icon: const Icon(
//                                           Icons.camera_alt,
//                                           size: 50,
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: pickAadharImage,
//                                         icon: const Icon(
//                                           Icons.image,
//                                           size: 50,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                       icon: const Icon(Icons.edit),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: textController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () async {
//                       if (textController.text.isNotEmpty) {
//                         try {
//                           await FirebaseFirestore.instance
//                               .collection("chat_rooms")
//                               .doc(chatroomID)
//                               .collection("messages")
//                               .doc()
//                               .set({
//                             "text": textController.text,
//                             "senderId": currentUserID,
//                             "timestamp": Timestamp.now(),
//                             "reciverid": widget.receiverId,
//                             "chatimage": imageUrl.isNotEmpty ? imageUrl : aadhar
//                           }).then((value) => {
//                                     FirebaseFirestore.instance
//                                         .collection("chat_rooms")
//                                         .doc(chatroomID)
//                                         .set({
//                                       "room": chatroomID,
//                                       "time": DateTime.now()
//                                     })
//                                   });
//                           textController.clear();
//                         } catch (e) {
//                           print("Error sending message: $e");
//                         }
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    Key? key,
    this.receiverId,
    this.chatroomid,
    this.imageurl,
  }) : super(key: key);

  final receiverId;
  final chatroomid;
  final imageurl;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final textController = TextEditingController();
  String receiverName = "";
  String image = "";
  bool isLoading = true;

  File? doc;
  String docUrl = "";
  File? imageFile;
  String imageUrl = "";

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

  @override
  void initState() {
    super.initState();
    fetchReceiverData();
  }

  Future<void> fetchReceiverData() async {
    try {
      final receiverDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.receiverId)
          .get();
      if (receiverDoc.exists) {
        setState(() {
          receiverName = receiverDoc["FirstName"] ?? "";
          image = receiverDoc["ImageUrl"] ?? "";
        });
      } else {
        print("Receiver document does not exist");
      }
    } catch (e) {
      print("Error fetching receiver's data: $e");
    }
  }

  String generateChatroomID(String uid1, String uid2) {
    final userIds = [uid1, uid2];
    userIds.sort();
    return userIds.join("_");
  }

  @override
  Widget build(BuildContext context) {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    final chatroomID = generateChatroomID(currentUserID, widget.receiverId);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: image.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(image),
                )
              : const Icon(Icons.person),
        ),
        title: Text(
          receiverName,
          style: const TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.green.withOpacity(0.8),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chat_rooms")
                  .doc(chatroomID)
                  .collection("messages")
                  .orderBy("timestamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data!.docs[index].data();
                    final isCurrentUser = message["senderId"] == currentUserID;

                    return Align(
                      alignment: isCurrentUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: isCurrentUser
                              ? Colors.blue[100]
                              : Colors.grey[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (message["text"] != null) Text(message["text"]),
                            if (message["chatimage"] != null)
                              Image.network(message["chatimage"]),
                            Text(
                              isCurrentUser ? "You" : receiverName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: getImageCamera,
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      if (textController.text.isNotEmpty) {
                        try {
                          await FirebaseFirestore.instance
                              .collection("chat_rooms")
                              .doc(chatroomID)
                              .collection("messages")
                              .doc()
                              .set({
                            "text": textController.text,
                            "senderId": currentUserID,
                            "timestamp": Timestamp.now(),
                            "receiverId": widget.receiverId,
                            "chatimage": imageUrl.isNotEmpty ? imageUrl : "",
                          }).then((value) => {
                                    FirebaseFirestore.instance
                                        .collection("chat_rooms")
                                        .doc(chatroomID)
                                        .set({
                                      "room": chatroomID,
                                      "time": DateTime.now()
                                    })
                                  });
                          textController.clear();
                        } catch (e) {
                          print("Error sending message: $e");
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
