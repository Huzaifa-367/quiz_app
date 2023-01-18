import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ResultScreen(
      score: 0,
    ));

class ResultScreen extends StatefulWidget {
  final int score;

  const ResultScreen({Key? key, required this.score}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}

class _ResultScreenState extends State<ResultScreen> {
  late double correctNumber;
  bool isPlaying = false;
  late ConfettiController _controllerTopCenter;

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  void initState() {
    correctNumber = widget.score / 10;
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int correctNumberInt = correctNumber.toInt();

    setState(() {
      _controllerTopCenter.play();
    });

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: const Color(0xff14154F),
          body: Padding(
            padding: const EdgeInsets.only(top: (0.05)),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Congratulations!",
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                            color: const Color(0xffFFBA07),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: (0.05)),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xff5A88B0),
                          radius: 120,
                          child: Image.asset("assets/icons/kupa.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff5A88B0),
                        radius: 80,
                        child: Image.asset("assets/icons/kupa.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff5A88B0),
                        radius: 80,
                        child: Image.asset("assets/icons/kupa.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff5A88B0),
                        radius: 80,
                        child: Image.asset("assets/icons/kupa.png"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: const Color(0xff5A88B0),
                        radius: 80,
                        child: Image.asset("assets/icons/kupa.png"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        ConfettiWidget(
          numberOfParticles: 100,
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: _controllerTopCenter,
          shouldLoop: true, // start again as soon as the animation is finished
          colors: const [
            Color.fromARGB(255, 43, 247, 50),
            Color.fromARGB(255, 1, 141, 255),
            Color.fromARGB(255, 255, 0, 85),
            Color.fromARGB(255, 255, 157, 9),
            Color.fromARGB(255, 217, 0, 255),
            Color.fromARGB(255, 183, 255, 0),
            Color.fromARGB(255, 0, 72, 131),
            Color.fromARGB(255, 189, 0, 63),
            Color.fromARGB(255, 214, 9, 255),
            Color.fromARGB(255, 200, 255, 0),
          ], // manually specify the colors to be used
          createParticlePath: drawStar, // define a custom shape/path.
        )
      ],
    );
  }
}
