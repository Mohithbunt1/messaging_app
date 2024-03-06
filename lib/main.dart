import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:messaging_app/Screens/LoginScreen/SignIn.dart';
import 'package:messaging_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInPage(),
    );
  }
}







































































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class ChatRoomScreen extends StatefulWidget {
//   const ChatRoomScreen({
//     Key? key,
//     required this.chatroomid,
//     required this.receiverId,
//   }) : super(key: key);

//   final String chatroomid;
//   final String receiverId;

//   @override
//   State<ChatRoomScreen> createState() => _ChatRoomScreenState();
// }

// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   final textController = TextEditingController();
//   String receiverName = "";
//   String image = "";

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

//   @override
//   Widget build(BuildContext context) {
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
//                   .doc(widget.chatroomid)
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
//                 final messages = snapshot.data?.docs ?? [];
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index].data();
//                     final isSentByCurrentUser = message["senderId"] ==
//                         FirebaseAuth.instance.currentUser!.uid;
//                     return Align(
//                       alignment: isSentByCurrentUser
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: isSentByCurrentUser
//                               ? Colors.blue[100]
//                               : Colors.grey[200],
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(message["text"]),
//                             Text(
//                               isSentByCurrentUser ? "You" : receiverName,
//                               style: const TextStyle(
//                                   fontSize: 12, color: Colors.black54),
//                             )
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
//               height: 160,
//               child: Row(
//                 children: [
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
//                         await FirebaseFirestore.instance
//                             .collection("chat_rooms")
//                             .doc(widget.chatroomid)
//                             .collection("messages")
//                             .add({
//                           "text": textController.text,
//                           "senderId": FirebaseAuth.instance.currentUser!.uid,
//                           "timestamp": Timestamp.now(),
//                         });
//                         textController.clear();
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


      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection("chat_rooms")
      //       .doc(widget.chatroomid)
      //       .collection("messages")
      //       .orderBy("timestamp", descending: false)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //     } else {}
      //     // final messages = snapshot.data!.docs
      //     //     .map((doc) => doc.data() as Map<String, dynamic>)
      //     //     .toList();
      //     return Column(
      //       children: [
      //         Expanded(
      //           child: ListView.builder(
      //             reverse: true,
      //             itemCount: messages.length,
      //             itemBuilder: (context, index) {
      //               final message = messages[index];
      //               final isSentByCurrentUser = message["senderId"] ==
      //                   FirebaseAuth.instance.currentUser!.uid;

      //               return Align(
      //                 alignment: isSentByCurrentUser
      //                     ? Alignment.centerRight
      //                     : Alignment.centerLeft,
      //                 child: Container(
      //                   margin: const EdgeInsets.symmetric(
      //                       vertical: 5, horizontal: 10),
      //                   padding: const EdgeInsets.all(10),
      //                   decoration: BoxDecoration(
      //                     color: isSentByCurrentUser
      //                         ? Colors.blue[200]
      //                         : Colors.grey[300],
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(8)),
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(message["text"]),
      //                       Text(
      //                         isSentByCurrentUser ? "You" : widget.receiverId,
      //                         style: const TextStyle(fontSize: 12),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //         Container(
      //           color: Colors.transparent,
      //           height: 85,
      //           child: Padding(
      //             padding: const EdgeInsets.all(15.0),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: TextField(
      //                     controller: textController,
      //                     decoration: const InputDecoration(
      //                       focusedBorder: OutlineInputBorder(
      //                         borderSide: BorderSide(
      //                           style: BorderStyle.solid,
      //                           color: Colors.black38,
      //                         ),
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(10)),
      //                       ),
      //                       enabledBorder: OutlineInputBorder(
      //                         borderSide: BorderSide(
      //                           style: BorderStyle.solid,
      //                           color: Colors.black38,
      //                         ),
      //                         borderRadius:
      //                             BorderRadius.all(Radius.circular(10)),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 IconButton(
      //                   icon: const Icon(Icons.send),
      //                   onPressed: () async {
      //                     if (textController.text.isNotEmpty) {
      //                       await FirebaseFirestore.instance
      //                           .collection("chat_rooms")
      //                           .doc(widget.chatroomid)
      //                           .collection("messages")
      //                           .add({
      //                         "text": textController.text,
      //                         "senderId":
      //                             FirebaseAuth.instance.currentUser!.uid,
      //                         "timestamp": Timestamp.now(),
      //                         "reciverid": widget.receiverId
      //                       });
      //                       textController.clear();
      //                     }
      //                   },
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),


















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
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:messaging_app/Screens/LoginScreen/SignIn.dart';
// // import 'package:messaging_app/Screens/utilities/detailsPage.dart';
// // import 'package:messaging_app/Screens/utilities/searchbox.dart';
// // import 'package:messaging_app/Screens/widgets/Logout.dart';

// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({Key? key, required this.url, required this.number});

// //   final String? url;
// //   final String? number;

// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   Future<DocumentSnapshot> _getUserData() async {
// //     try {
// //       final currentUser = FirebaseAuth.instance.currentUser;
// //       print(
// //           ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!>>>>>>>.${currentUser}");
// //       if (currentUser != null) {
// //         return await FirebaseFirestore.instance
// //             .collection("users")
// //             .doc(currentUser.uid)
// //             .get();
// //       }
// //       print(
// //           ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${currentUser}");
// //       throw Exception(
// //           '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.User not authenticated');
// //     } catch (e) {
// //       throw Exception(
// //           '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Error fetching user data: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.green.withOpacity(0.8),
// //         title: const Text(
// //           "Chit_Chat",
// //           style: TextStyle(),
// //         ),
// //         actions: [
// //           IconButton(
// //             onPressed: () {
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => const SearchBox(),
// //                 ),
// //               );
// //             },
// //             icon: const Icon(Icons.person_search_sharp),
// //           )
// //         ],
// //       ),
// //       drawer: Drawer(
// //         child: Container(
// //           height: MediaQuery.of(context).size.height,
// //           width: MediaQuery.of(context).size.width,
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [Colors.green.withOpacity(0.8), Colors.white],
// //               begin: Alignment.topCenter,
// //               end: Alignment.bottomCenter,
// //             ),
// //           )   ,
// //           child: Column(
// //             children: [
// //               Container(
// //                 alignment: Alignment.bottomLeft,
// //                 width: MediaQuery.of(context).size.width,
// //                 height: 160,
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [
// //                       Theme.of(context).colorScheme.primaryContainer,
// //                       Theme.of(context)
// //                           .colorScheme
// //                           .primaryContainer
// //                           .withOpacity(1),
// //                     ],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                 ),
// //                 child: const Padding(
// //                   padding: EdgeInsets.all(25.0),
// //                   child: Text(
// //                     "Chit_Chat",
// //                     textDirection: TextDirection.ltr,
// //                     style: TextStyle(fontSize: 34),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //               FutureBuilder<DocumentSnapshot>(
// //                 future: _getUserData(),
// //                 builder: (context, snapshot) {
// //                   print(
// //                       ">>>>>>>>>>>>.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${snapshot.data}");
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   } else if (snapshot.hasError) {
// //                     print(
// //                         ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${snapshot.error}");
// //                     return Text('Error: ${snapshot.error}');
// //                   } else if (!snapshot.hasData || !snapshot.data!.exists) {
// //                     print(
// //                         ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${snapshot.error}");
// //                     print(
// //                         ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${snapshot.data}");
// //                     return const Text("No data found");
// //                   } else {
// //                     final data = snapshot.data!;
// //                     final imageUrl = widget.url;
// //                     final number = widget.number;

// //                     if (imageUrl == null || imageUrl.isEmpty) {
// //                       print(
// //                           ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.${imageUrl}");
// //                       return Column(
// //                         children: [
// //                           CircleAvatar(
// //                             radius: 100,
// //                             child: Icon(Icons.person),
// //                           ),
// //                           IconButton(
// //                             onPressed: () {
// //                               Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                   builder: (context) =>
// //                                       EditPage(number: number),
// //                                 ),
// //                               );
// //                             },
// //                             icon: Icon(Icons.edit),
// //                           ),
// //                         ],
// //                       );
// //                     }
// //                     return Column(
// //                       children: [
// //                         CircleAvatar(
// //                           radius: 100,
// //                           backgroundImage: NetworkImage(imageUrl),
// //                         ),
// //                         IconButton(
// //                           onPressed: () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => EditPage(number: number),
// //                               ),
// //                             );
// //                           },
// //                           icon: Icon(Icons.edit),
// //                         ),
// //                         const SizedBox(
// //                           height: 30,
// //                         ),
// //                         Text(
// //                           "Username -${data["FirstName"]}",
// //                           style: const TextStyle(
// //                               fontSize: 24, fontWeight: FontWeight.w500),
// //                         ),
// //                         const SizedBox(
// //                           height: 20,
// //                         ),
// //                         Text(
// //                           "Age -${data["Age"]}",
// //                           style: const TextStyle(
// //                               fontSize: 24, fontWeight: FontWeight.w500),
// //                         ),
// //                         const SizedBox(
// //                           height: 20,
// //                         ),
// //                         Text(
// //                           "Bio -${data["Bio"]}",
// //                           style: const TextStyle(
// //                               fontSize: 24, fontWeight: FontWeight.w500),
// //                         ),
// //                         const Divider(
// //                           color: Color(0xAA884490),
// //                           thickness: 5,
// //                           endIndent: 10,
// //                           height: 10,
// //                           indent: 10,
// //                         ),
// //                       ],
// //                     );
// //                   }
// //                 },
// //               ),
// //               Container(
// //                 alignment: Alignment.bottomCenter,
// //                 child: const Column(
// //                   children: [
// //                     SizedBox(
// //                       height: 300,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const Divider(
// //                   color: Color(0xAA884490),
// //                   thickness: 2,
// //                   endIndent: 5,
// //                   height: 0.1,
// //                   indent: 5),
// //               const SizedBox(
// //                 height: 20,
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 30),
// //                 child: InkWell(
// //                   onTap: () async {
// //                     await FirebaseAuth.instance.signOut();
// //                     Navigator.pushReplacement(
// //                         context,
// //                         MaterialPageRoute(
// //                           builder: (context) => const SignInPage(),
// //                         ));
// //                   },
// //                   child: const Logout(),
// //                 ),
// //               ),
// //               const SizedBox(
// //                 height: 10,
// //               ),
// //               TextButton(
// //                 onPressed: () {},
// //                 child: const Text(
// //                   "Privacy and Policy",
// //                   style: TextStyle(fontSize: 16),
// //                 ),
// //               ),
// //               TextButton(
// //                 onPressed: () {},
// //                 child: const Text(
// //                   "About us",
// //                   style: TextStyle(fontSize: 16),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:messaging_app/Screens/LoginScreen/SignIn.dart';
// import 'package:messaging_app/Screens/MainScreen/chatroom.dart';
// import 'package:messaging_app/Screens/utilities/detailsPage.dart';
// import 'package:messaging_app/Screens/utilities/searchbox.dart';
// import 'package:messaging_app/Screens/widgets/Logout.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key, required this.url, required this.number});

//   final String? url;
//   final String? number;

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   Future<DocumentSnapshot> _getUserData() async {
//     try {
//       final currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         return await FirebaseFirestore.instance
//             .collection("users")
//             .doc(currentUser.uid)
//             .get();
//       }
//       throw Exception('User not authenticated');
//     } catch (e) {
//       throw Exception('Error fetching user data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green.withOpacity(0.8),
//         title: Text(
//           "Chit_Chat",
//           style: TextStyle(),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const SearchBox(),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.person_search_sharp),
//           )
//         ],
//       ),
//       drawer: Drawer(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.green.withOpacity(0.8), Colors.white],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.bottomLeft,
//                 width: MediaQuery.of(context).size.width,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Theme.of(context).colorScheme.primaryContainer,
//                       Theme.of(context)
//                           .colorScheme
//                           .primaryContainer
//                           .withOpacity(1),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(25.0),
//                   child: Text(
//                     "Chit_Chat",
//                     textDirection: TextDirection.ltr,
//                     style: TextStyle(fontSize: 34),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               FutureBuilder<DocumentSnapshot>(
//                 future: _getUserData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else if (!snapshot.hasData || !snapshot.data!.exists) {
//                     return const Text("No data found");
//                   } else {
//                     final data = snapshot.data!;
//                     final imageUrl = widget.url;
//                     final number = widget.number;

//                     if (imageUrl == null || imageUrl.isEmpty) {
//                       return Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 100,
//                             child: Icon(Icons.person),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       EditPage(number: number),
//                                 ),
//                               );
//                             },
//                             icon: Icon(Icons.edit),
//                           ),
//                         ],
//                       );
//                     }
//                     return Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 100,
//                           backgroundImage: NetworkImage(imageUrl),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => EditPage(number: number),
//                               ),
//                             );
//                           },
//                           icon: Icon(Icons.edit),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Text(
//                           "Username -${data["FirstName"]}",
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Age -${data["Age"]}",
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.w500),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           "Bio -${data["Bio"]}",
//                           style: const TextStyle(
//                               fontSize: 24, fontWeight: FontWeight.w500),
//                         ),
//                         const Divider(
//                           color: Color(0xAA884490),
//                           thickness: 5,
//                           endIndent: 10,
//                           height: 10,
//                           indent: 10,
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//               Container(
//                 alignment: Alignment.bottomCenter,
//                 child: const Column(
//                   children: [
//                     SizedBox(
//                       height: 300,
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(
//                   color: Color(0xAA884490),
//                   thickness: 2,
//                   endIndent: 5,
//                   height: 0.1,
//                   indent: 5),
//               const SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: InkWell(
//                   onTap: () async {
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SignInPage(),
//                         ));
//                   },
//                   child: const Logout(),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "Privacy and Policy",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "About us",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("users").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData) {
//             return const Center(child: Text("No users found"));
//           }
//           final users = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final userData = users[index].data() as Map<String, dynamic>;
//               final userId = users[index].id;
//               final firstName = userData['FirstName'] ?? '';
//               if (userId != FirebaseAuth.instance.currentUser?.uid) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChatRoomScreen(
//                           reciverId: userId,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     child: ListTile(
//                       title: Text(firstName),
//                     ),
//                   ),
//                 );
//               } else {
//                 return const SizedBox();
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// // }import 'package:cloud_firestore/cloud_firestore.dart';




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

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
//                       return Column(
//                         children: [
//                           ListTile(
//                             title: Text(message["text"]),
//                             subtitle: Text(message["senderId"]),
//                           ),
//                           ListTile(
//                             title: Text(message["text"]),
//                             subtitle: Text(message["reciverId"]),
//                           )
//                         ],
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
//                               "reciverId": widget.reciverId,
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
