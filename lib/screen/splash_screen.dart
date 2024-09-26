import 'dart:math';
import 'package:flutter/material.dart';
import 'package:water_tracker_app/screen/on_boarding_screen.dart';
import 'package:water_tracker_app/utils/colors.dart';

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward(); // Forward the animation for 5 seconds

    // Listen for animation status
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate to the new screen after 5 seconds
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: MultiWavePainter(_controller.value),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container()
              ],
            ),
          );
        },
      ),
    );
  }
}

class MultiWavePainter extends CustomPainter {
  final double animationValue;
  MultiWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the first wave (light blue)
    final paint1 = Paint()
      ..color = priColor.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Paint for the second wave (darker blue)
    final paint2 = Paint()
      ..color = priColor!.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // First wave
    _drawWave(canvas, size, paint1,
        waveHeightFactor: 0.10, waveSpeedFactor: 0.4, waveFrequency: 1.9);

    // Second wave (slightly different parameters)
    _drawWave(canvas, size, paint2,
        waveHeightFactor: 0.15, waveSpeedFactor: 0.7, waveFrequency: 1.5);
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    Paint paint, {
    required double waveHeightFactor,
    required double waveSpeedFactor,
    required double waveFrequency,
  }) {
    final path = Path();
    final waveHeight = size.height * waveHeightFactor;
    final waveSpeed = size.width * waveSpeedFactor;
    final yOffset = size.height * 0.8; // Middle of the container

    path.moveTo(0, yOffset);

    for (double x = 0; x <= size.width; x++) {
      double y =
          sin((x / waveSpeed + animationValue * 2 * pi) * waveFrequency) *
                  waveHeight +
              yOffset;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(MultiWavePainter oldDelegate) => true;
}
