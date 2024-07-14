import 'package:flutter/material.dart';

class CloudAnimation extends StatefulWidget {
  @override
  _CloudAnimationState createState() => _CloudAnimationState();
}

class _CloudAnimationState extends State<CloudAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  late Animation<double> _opacityAnimation1;
  late Animation<double> _opacityAnimation2;
  late Animation<double> _opacityAnimation3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Adjust duration as needed
    );

    _controller.repeat(reverse: false); // Make clouds move back and forth
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = 400.0;

    _animation1 = Tween<double>(begin: -150.0, end: screenWidth - 90)
        .animate(_controller);
    _animation2 = Tween<double>(begin: -300.0, end: screenWidth - 90)
        .animate(_controller);
    _animation3 = Tween<double>(begin: -400.0, end: screenWidth - 90)
        .animate(_controller);

    _opacityAnimation1 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1, 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation2 = Tween<double>(begin: 0.9, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation3 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );

    return Stack(
      children: [
        // Your weather widgets here

        // First animated cloud
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 10.0, // Adjust positioning as needed
              left: _animation1.value,
              child: FadeTransition(
                opacity: _opacityAnimation1,
                child: CustomPaint(
                  painter: CloudPainter(),
                  child: const SizedBox(width: 100, height: 50),
                ),
              ),
            );
          },
        ),

        // Second animated cloud
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 70.0, // Adjust positioning as needed
              left: _animation2.value,
              child: FadeTransition(
                opacity: _opacityAnimation2,
                child: CustomPaint(
                  painter: CloudPainter(),
                  child: const SizedBox(width: 120, height: 60),
                ),
              ),
            );
          },
        ),

        // Third animated cloud
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 200.0, // Adjust positioning as needed
              left: _animation3.value,
              child: FadeTransition(
                opacity: _opacityAnimation3,
                child: CustomPaint(
                  painter: CloudPainter(),
                  child: const SizedBox(width: 140, height: 70),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.cubicTo(size.width * 0.1, size.height * 0.5, size.width * 0.1,
        size.height * 0.2, size.width * 0.3, size.height * 0.2);
    path.cubicTo(size.width * 0.4, 0, size.width * 0.6, 0, size.width * 0.7,
        size.height * 0.2);
    path.cubicTo(size.width * 0.8, size.height * 0.2, size.width * 0.8,
        size.height * 0.3, size.width * 0.9, size.height * 0.3);
    path.cubicTo(size.width * 0.95, size.height * 0.5, size.width * 0.8,
        size.height * 0.7, size.width * 0.6, size.height * 0.6);
    path.cubicTo(size.width * 0.5, size.height * 0.8, size.width * 0.3,
        size.height * 0.8, size.width * 0.2, size.height * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
