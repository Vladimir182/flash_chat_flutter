import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      _auth.authStateChanges().listen((user) {
        if (user != null) {
          loggedInUser = user;
          print("Користувач увійшов: ${loggedInUser.email}");
        }
      });
    } catch (e) {
      print("Користувач вийшов");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          TextButton(
            // icon: const Icon(Icons.close),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: 10), // Видаляє зайві відступи
              minimumSize: const Size(0, 0), // Забезпечує мінімальний розмір
              tapTargetSize: MaterialTapTargetSize
                  .shrinkWrap, // Зменшує область натискання
              foregroundColor: Colors.white, // Колір тексту
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              try {
                await _auth.signOut();
                navigator.pop();
              } catch (e) {
                print("Помилка виходу $e");
              }
            },
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
