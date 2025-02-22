import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/blurred_loading_overlay.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.blueAccent,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_circle_left_outlined,
                size: 30,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: kInputDecoration.copyWith(
                      hintText: 'Enter your password.',
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.blueAccent,
                      onPressed: () async {
                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Email and password cannot be empty'),
                            ),
                          );
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        final navigator = Navigator.of(context);
                        try {
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          navigator.pushNamed(ChatScreen.id);
                          setState(() {
                            isLoading = false;
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          print(e);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
        BlurredLoadingOverlay(isLoading: isLoading)
      ],
    );
  }
}
