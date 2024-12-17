import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final TextEditingController messageController = TextEditingController();
  late StreamSubscription<User?>? _authSubscription;
  late User loggedInUser;
  late String messageText = '';
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCurrentUser();
    messagesStream();
  }

  void getCurrentUser() {
    _authSubscription = _auth.authStateChanges().listen(
      (user) {
        if (user != null) {
          loggedInUser = user;
          print("Користувач увійшов: ${loggedInUser.email}");
        } else {
          print("Користувач не авторизований");
        }
      },
      onError: (e) {
        print("Помилка автентифікації: $e");
      },
    );
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      print('snapshots!!!!!!! ${snapshot.docs}');
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
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              //for a test. I have using this button

              // getMessages();
              final navigator = Navigator.of(context);
              try {
                await _auth.signOut();
                navigator.pop();
              } catch (e) {
                print("Помилка виходу $e");
              }
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? spinkit
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('messages').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final messages = snapshot.data!.docs;

                        List<Text> messagesWidgets = [];
                        for (var message in messages) {
                          final messageText = message['text'];
                          final messageSender = message['sender'];
                          final messageWidget =
                              Text('$messageSender: $messageText');
                          messagesWidgets.add(messageWidget);
                        }

                        if (messagesWidgets.isEmpty) {
                          return const Center(
                              child: Text('Немає повідомлень.'));
                        }

                        return Column(
                          children: messagesWidgets,
                        );
                      }

                      return const Center(
                        child: spinkit,
                      );
                    },
                  ),
                  Container(
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            onChanged: (value) {
                              messageText = value;
                            },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //messageText + loggedInUser.email
                            if (messageText.trim().isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              _firestore.collection('messages').add({
                                'text': messageText,
                                'sender': loggedInUser.email,
                              });
                            }

                            setState(() {
                              isLoading = false;
                            });
                            messageController.clear();
                            messageText = '';
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
