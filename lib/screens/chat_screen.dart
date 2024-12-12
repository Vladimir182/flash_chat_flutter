import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late User loggedInUser;
  late String messageText;

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

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  void messagesStream<QuerySnapshot>() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
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
              //for a test. I have using this button
              messagesStream();

              // getMessages();
              // final navigator = Navigator.of(context);
              // try {
              //   await _auth.signOut();
              //   navigator.pop();
              // } catch (e) {
              //   print("Помилка виходу $e");
              // }
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
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //messageText + loggedInUser.email
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
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
