import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../animations/animations.dart';
import '../components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

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
                Flexible(
                  child: Hero(
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
                ),
                AnimatedBuilder(
                  animation: colorAnimation
                      .animation, // Передаємо нашу анімацію кольору
                  builder: (context, child) {
                    return AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Flash Chat',
                          speed: const Duration(milliseconds: 70),
                          textStyle: TextStyle(
                            color: colorAnimation.animation
                                .value, // Колір змінюється з анімацією
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
            ),
            RoundedButton(
              title: 'Registration',
              color: Colors.blueAccent,
              onPressed: () =>
                  Navigator.pushNamed(context, RegistrationScreen.id),
            ),
          ],
        ),
      ),
    );
  }
}
