import 'package:flutter/material.dart';

class LogoAnimation {
  final AnimationController controller;
  late Animation animation;

  LogoAnimation({required TickerProvider vsync})
      : controller = AnimationController(
          duration: const Duration(seconds: 1),
          vsync: vsync,
        ) {
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  void dispose() {
    controller.dispose();
  }
}

class ColorAnimation {
  final AnimationController controller;
  late Animation<Color?> animation;

  ColorAnimation({required TickerProvider vsync})
      : controller = AnimationController(
          vsync: vsync,
          duration: const Duration(seconds: 2),
        ) {
    animation =
        ColorTween(begin: Colors.lightBlueAccent, end: Colors.blueAccent)
            .animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
  void dispose() {
    controller.dispose();
  }
}
