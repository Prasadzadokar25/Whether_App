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
      duration: const Duration(seconds: 20), // Adjust duration as needed
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
    final screenWidth = MediaQuery.of(context).size.width / 1.5;

    _animation1 = Tween<double>(begin: -150.0, end: screenWidth - 90)
        .animate(_controller);
    _animation2 = Tween<double>(begin: -300.0, end: screenWidth - 90)
        .animate(_controller);
    _animation3 = Tween<double>(begin: -400.0, end: screenWidth - 90)
        .animate(_controller);

    _opacityAnimation1 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.1
          , 1.0, curve: Curves.easeOut)),
    );
    _opacityAnimation2 = Tween<double>(begin: 0.9, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(
            0.8,
            1.0,
            curve: Curves.easeOut,
          )),
    );
    _opacityAnimation3 = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.8, 1.0, curve: Curves.easeOut)),
    );

    return Stack(
      children: [
        // First animated cloud
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 10.0,
              left: _animation1.value,
              child: FadeTransition(
                  opacity: _opacityAnimation1,
                  child: const CloudDrawing(
                    size: 90,
                  )),
            );
          },
        ),

        // Second animated cloud
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Positioned(
              top: 70.0,
              left: _animation2.value,
              child: FadeTransition(
                  opacity: _opacityAnimation2,
                  child: const CloudDrawing(
                    size: 90,
                  )),
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
                  child: const CloudDrawing(
                    size: 90,
                  )),
            );
          },
        ),
      ],
    );
  }
}

class CloudDrawing extends StatefulWidget {
  final double size;
  const CloudDrawing({required this.size, super.key});

  @override
  State<CloudDrawing> createState() => _CloudDrawingState();
}

class _CloudDrawingState extends State<CloudDrawing> {
  @override
  Widget build(BuildContext context) {
    double width = widget.size;
    double height = widget.size * 70 / 90;
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: height * 0.45,
                width: width * 0.66,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(254, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              )),
          Positioned(
              left: width * 0.23,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: width * 0.27,
                    backgroundColor: Colors.white,
                  ),
                ],
              )),
          Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: height * 0.45,
                width: width * 0.66,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(120, 255, 255, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ))
        ],
      ),
    );
  }
}
