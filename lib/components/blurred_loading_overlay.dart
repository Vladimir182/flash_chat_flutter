import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants.dart';

class BlurredLoadingOverlay extends StatelessWidget {
  const BlurredLoadingOverlay({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLoading)
          Positioned.fill(
            child: Stack(
              children: [
                // Блюр
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black
                        .withValues(alpha: 0.2), // Темний прозорий фон
                  ),
                ),
                // Ви можете додати інший контент або анімації поверх цього шару
                const Center(
                  child: spinkit,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
