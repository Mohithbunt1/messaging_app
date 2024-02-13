import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.url});

  final String? url;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: const Text(
          "Chit_Chat",
          style: TextStyle(),
        ),
      ),
      drawer: Drawer(
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

                  if (imageUrl == null || imageUrl.isEmpty) {
                    return const CircleAvatar(
                      radius: 100,
                      child: Icon(Icons.person),
                    );
                  }

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Username -${data["FirstName"]}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Age -${data["Age"]}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Bio -${data["Bio"]}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Divider(
                        color: Color.fromARGB(0, 0, 0, 255),
                        thickness: 21,
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
