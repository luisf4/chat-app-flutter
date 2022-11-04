// ignore_for_file: prefer_const_constructors, must_be_immutable, curly_braces_in_flow_control_structures, avoid_unnecessary_containers
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection('mensagens').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();

                      if (snapshot.hasError)
                        return Text(snapshot.error.toString());

                      var documents = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (_, index) {
                          var document = documents[index] as DocumentSnapshot;

                          return ListTile(
                            leading: CircleAvatar(),
                            title: Text(document['mensagem']),
                            subtitle: Text(document['usuario']),
                            // trailing: Text(document['data']),
                          );
                        },
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
