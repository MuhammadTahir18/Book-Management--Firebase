import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedBookLogo extends StatelessWidget {
  final Animation<double> rotation;
  final Animation<double> scale;
  final Animation<double> opacity;

  const AnimatedBookLogo({
    super.key,
    required this.rotation,
    required this.scale,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: ScaleTransition(
        scale: scale,
        child: RotationTransition(
          turns: rotation,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.22),
                  blurRadius: 48,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/book.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}