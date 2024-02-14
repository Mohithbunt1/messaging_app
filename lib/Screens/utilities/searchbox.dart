import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Screens/CustomizedWidget/textfield.dart';
import 'package:messaging_app/Screens/MainScreen/chatroom.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 211, 248, 227),
          flexibleSpace: const FlexibleSpaceBar(),
          toolbarHeight: 80,
          title: CustomTextField(
              controller: searchcontroller, hintText: "Search here"),
        ),
        body: searchcontroller.text.isEmpty
            ? StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatRoomScreen(data: snapshot.data!),
                                ),
                              );
                            },
                            title:
                                Text(snapshot.data!.docs[index]["FirstName"]),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            : StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index]["FirstName"]
                                .toString()
                                .toLowerCase()
                                .contains(
                                    searchcontroller.text.toLowerCase()) ||
                            snapshot.data!.docs[index]["Phone number"]
                                .toString()
                                .contains(
                                  searchcontroller.text.toLowerCase(),
                                ) ||
                            snapshot.data!.docs[index]["LastName"]
                                .toString()
                                .toLowerCase()
                                .contains(
                                  searchcontroller.text.toLowerCase(),
                                )) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatRoomScreen(data: snapshot.data!),
                                  ),
                                );
                              },
                              title: Text(
                                snapshot.data!.docs[index]["FirstName"]
                                    ["LastName"],
                              ),
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 500),
                          child: Text(
                            "No data found",
                            style: TextStyle(fontSize: 40),
                          ),
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }));
  }
}
