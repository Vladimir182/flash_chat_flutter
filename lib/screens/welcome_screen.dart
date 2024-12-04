import 'package:flash_chat_flutter/animations/animations.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late LogoAnimation logoAnimation;
  late ColorAnimation colorAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logoAnimation = LogoAnimation(vsync: this);
    colorAnimation = ColorAnimation(vsync: this);

    logoAnimation.controller.forward();
    colorAnimation.controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: AnimatedBuilder(
                    animation: logoAnimation.animation,
                    builder: (context, child) {
                      return SizedBox(
                        height: logoAnimation.animation.value * 65,
                        child: Image.asset('images/logo.png'),
                      );
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: colorAnimation.animation,
                  builder: (context, child) {
                    return Text(
                      'Flash Chat',
                      style: TextStyle(
                        color: colorAnimation.animation.value,
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  minimumSize: const Size(200.0, 50.0),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: const Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
