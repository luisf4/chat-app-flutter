// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable
import 'package:chat_app/models/messageModel.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

String _user = '';

@override
void initState() {
  initState();
  // getUser();
}

var uuid = Uuid();

final _searchText = TextEditingController();
const _text = '';

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

        // scaffold
        child: Scaffold(
          //appbar
          appBar: AppBar(),
          //body
          body: SingleChildScrollView(
            child: Column(
              children: [
                // SearchBar
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _searchText,
                    decoration: InputDecoration(
                      hintText: "Search user by email",
                      suffixIcon: InkWell(
                        child: Icon(Icons.search),
                        onTap: () {
                          setState(
                            () {
                              _searchText;
                            },
                          );
                        },
                      ),
                    ),
                    onChanged: (text) {
                      setState(() {
                        _searchText;
                      });
                    },
                  ),
                ),
                Text(_text),
                //Streambuilder of the results of the serach
                Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('email',
                              isEqualTo: _searchText.text.toString())
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
                                        talkUser(
                                            document['uid'],
                                            FirebaseAuth
                                                .instance.currentUser?.uid
                                                .toString()
                                                .trim(),
                                            document['name']);
                                      },
                                      child: ListTile(
                                        leading: Icon(Icons.email),
                                        title: Text(document['name']),
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

// Função que cria uma conversa nova no banco de dados
  Future talkUser(senderUid, recipientUid, recipientName) async {
    Conversation newMessage = Conversation(
      senderUid: recipientUid.toString().trim(),
      recipientUid: senderUid.toString().trim(),
      recipientName: recipientName,
      lastMessage: 'Hello !',
      timestamp: Timestamp.now(),
      id: uuid.v4(),
    );

    saveTalkUser(newMessage).then((_) {
      print('Message saved successfully!');
    }).catchError((error) {
      print('Failed to save message: $error');
    });
  }
}
