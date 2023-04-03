// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  // Variaveis necessarias
  var messageID;
  var contactName;

  ChatPage({super.key, required this.messageID, required this.contactName});

  @override
  State<ChatPage> createState() => _SearchPageState();
}

// Variaveis
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
          body: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                //add your other widgets here
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .doc(widget.messageID)
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
                              child: Column(children: [
                                if (document['email'] ==
                                    FirebaseAuth.instance.currentUser!.email
                                        .toString()) ...[
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        document['message'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        document['message'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ]
                              ]));
                        },
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(15.0),
                    height: 61,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35.0),
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ],
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.face,
                                      color: Colors.amber,
                                    ),
                                    onPressed: () {}),
                                Expanded(
                                  child: TextField(
                                    controller: _message,
                                    decoration: InputDecoration(
                                        hintText: "Type Something...",
                                        hintStyle:
                                            TextStyle(color: Colors.amber),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                          child: InkWell(
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                            onTap: () {
                              sendMessage(widget.messageID, 'user',
                                  _message.text.toString());
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendMessage(randomId, user, message) async {}
}
