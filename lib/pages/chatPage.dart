// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables, must_be_immutable, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/messageModel.dart';

class ChatPage extends StatefulWidget {
  // Variaveis necessarias
  var messageID;
  var contactName;

  ChatPage({super.key, required this.messageID, required this.contactName});
  @override
  State<ChatPage> createState() => _SearchPageState();
}

// Variaveis
FirebaseFirestore firestore = FirebaseFirestore.instance;
final _message = TextEditingController();

class _SearchPageState extends State<ChatPage> {
  DateFormat dateFormat = DateFormat('hh:mm:ss');
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
            title: Text(
              widget.contactName.toString(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            actions: const [
              CircleAvatar(child: Icon(Icons.change_history_outlined)),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: getMessages(widget.messageID.toString()),
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
                          DateTime dateTime = document['timestamp'].toDate();
                          String formattedTime =
                              DateFormat('hh:mm').format(dateTime);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Column(
                              children: [
                                if (document['senderUid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                        .toString()) ...[
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromRGBO(75, 75, 75, 1),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                13, 10, 13, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  document['text'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  formattedTime,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          238, 238, 238, 1)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                100, 100, 100, 1),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  document['text'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1)),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  formattedTime,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color.fromRGBO(
                                                          238, 238, 238, 1)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          );
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
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: TextField(
                                      controller: _message,
                                      decoration: InputDecoration(
                                          hintText: "Type Something...",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                            icon: Icon(
                              Icons.send,
                              // color: Colors.amber,
                            ),
                            onPressed: () {
                              if (_message.text != "") {
                                saveMessage(widget.messageID);
                                _message.clear();
                              } else {
                                return;
                              }
                            }),
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

// Salvar uma nova mensagem no banco de dados
  Future<void> saveMessage(id) {
    Message message = Message(
      senderUid: FirebaseAuth.instance.currentUser!.uid.toString(),
      timestamp: Timestamp.now(),
      text: _message.text.toString().trim(),
    );
    return messagesCollection.doc(id).collection('chat').add(message.toMap());
  }
}
