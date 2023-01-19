// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  var messagesUser;

  var contactName;

  ChatPage({super.key, required this.messagesUser, this.contactName});

  @override
  State<ChatPage> createState() => _SearchPageState();
}

var searchText = '';
FirebaseFirestore firestore = FirebaseFirestore.instance;
final _message = TextEditingController();

class _SearchPageState extends State<ChatPage> {
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
            title: Text(widget.contactName.toString()),
          ),
          body: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(
                                      FirebaseAuth.instance.currentUser!.email!)
                                  .collection('chat')
                                  .doc(widget.messagesUser)
                                  .collection('messages')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox(
                                      child: Center(
                                          child: CircularProgressIndicator()));
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
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: ListTile(
                                        leading: CircleAvatar(),
                                        title: Text(document['user'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20)),
                                        subtitle: Text(document['message']),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _message,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueAccent,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: Icon(Icons.send, size: 40),
                            onTap: () {
                              sendMessage(
                                  widget.messagesUser,
                                  FirebaseAuth.instance.currentUser!.email!,
                                  _message.text);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future sendMessage(userEmail, user, message) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email!)
        .collection('chat')
        .doc(userEmail)
        .collection('messages')
        .doc(Uuid().v1())
        .set({
      'user': user.toString(),
      'message': message.toString(),
      'date': DateTime.now()
    });
  }
}
