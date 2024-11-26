import 'package:flutter/material.dart';

import '/screens/welcome_screen.dart';
import '/screens/login_screen.dart';
import '/screens/registration_screen.dart';
import '/screens/chat_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      // home: const WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        'login_screen': (context) => const LoginScreen(),
        'registration_screen': (context) => const RegistrationScreen(),
        'chat_screen': (context) => const ChatScreen(),
      },
    );
  }
}
