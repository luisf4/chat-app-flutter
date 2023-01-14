// ignore_for_file: prefer_const_constructors

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
                onPressed: () {},
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('linhas').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox(
                      child: Center(child: CircularProgressIndicator()));
                }

                if (snapshot.hasError) return Text(snapshot.error.toString());

                var documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (_, index) {
                    var document = documents[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(9, 10, 9, 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              document['photoUrl'],
                            ),
                          ),
                          title: Text(document['name']),
                          subtitle: Text(document['email']),
                        )
                      ),
                    );
                  },
                );
              },
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




