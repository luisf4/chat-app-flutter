// ignore_for_file: prefer_const_constructors, file_names, avoid_print

import 'package:chat_app/pages/chatPage.dart';
import 'package:chat_app/pages/searchPage.dart';
import 'package:chat_app/pages/userPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Contacts'),
            leading: IconButton(
              icon: Icon(Icons.heart_broken),
              onPressed: () {},
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: firestore
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email!)
                      .collection('chat')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(
                          child: Center(child: CircularProgressIndicator()));
                    }

                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    var documents = snapshot.data!.docs;

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: documents.length,
                      itemBuilder: (_, index) {
                        var document = documents[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatPage(messageID: document['messageID'],contactName: document['user'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(),
                              title: Text(document['user'],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              subtitle: Text(document['email']),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            label: const Text('Chat'),
            icon: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
