// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

var searchText = '';
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _SearchPageState extends State<SearchPage> {
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
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search user by email",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (text) {
                      setState(() {
                        searchText = text;
                      });
                    },
                  ),
                ),
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('email', isEqualTo: searchText)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return SizedBox(
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }

                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }

                        var documents = snapshot.data!.docs;

                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: documents.length,
                            itemBuilder: (_, index) {
                              var document = documents[index];
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: documents.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        talkUser(document['email'],
                                            document['user']);
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text(document['user']),
                                        subtitle: Text(
                                          document['email'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future talkUser(userEmail, user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email!)
        .collection('chat')
        .doc(userEmail)
        .set({
      'user': user,
      'email': userEmail,
      'message': 'Send me a message!',
      'date': DateTime.now()
    });
  }
}
