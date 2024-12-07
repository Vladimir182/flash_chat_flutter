import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/screens/welcome_screen.dart';
import '/screens/login_screen.dart';
import '/screens/registration_screen.dart';
import '/screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.black54),
          bodyMedium: TextStyle(color: Colors.black54),
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      // home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        ChatScreen.id: (context) => const ChatScreen(),
      },
    );
  }
}
