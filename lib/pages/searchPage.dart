// ignore_for_file: prefer_const_constructors, file_names, avoid_print, prefer_typing_uninitialized_variables, unused_element, no_leading_underscores_for_local_identifiers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

final _searchText = TextEditingController();
final _text = '';

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
                                        talkUser(document['email'],
                                            document['name'], _user);
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
  Future talkUser(talkUserEmail, talkUserName, user) async {
    var randomId = Uuid().v1();

    // Cria a conversa no banco de dados do usuario fazendo a pesquisa
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email!.toString())
        .collection('chat')
        .doc(Uuid().v1())
        .set({
      'messageID': randomId,
      'user': talkUserName,
      'email': talkUserEmail,
      'message': 'Send me a message!',
      'date': DateTime.now()
    });

    // Cria a conversa na conta do outro usuario
    await FirebaseFirestore.instance
        .collection('users')
        .doc(talkUserEmail)
        .collection('chat')
        .doc(Uuid().v1())
        .set({
      'messageID': randomId,
      'user': user,
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'message': 'Send me a message!',
      'date': DateTime.now()
    });

    // Cria uma conversa com o id na table messages no banco de dados com a mensagem inicial "send me a message!"
    await FirebaseFirestore.instance
        .collection('messages')
        .doc(randomId)
        .collection('chat')
        .doc(Uuid().v1())
        .set({
      'messageID': randomId,
      'user': user,
      'email': FirebaseAuth.instance.currentUser!.email!.toString(),
      'message': 'Send me a message!',
      'date': DateTime.now()
    });
  }
}
