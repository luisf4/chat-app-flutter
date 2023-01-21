// ignore_for_file: file_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(appBar: AppBar(),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(FirebaseAuth.instance.currentUser!.email.toString()),
                  ElevatedButton(
                    onPressed: () => singOut(),
                    child: Text('sig out'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future singOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }
}
