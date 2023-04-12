import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

class _ResultScreenState extends State<ResultScreen>
    with TickerProviderStateMixin {
  late double correctNumber;
  bool isPlaying = false;
  late ConfettiController _controllerTopCenter;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  final _rows = <PlutoRow>[
    PlutoRow(
      cells: {
        '1': PlutoCell(value: 'MCQS'),
        '2': PlutoCell(value: "1"),
        '3': PlutoCell(value: '2'),
        '4': PlutoCell(value: '3'),
      },
    ),
    PlutoRow(
      cells: {
        '1': PlutoCell(value: 'Rapid'),
        '2': PlutoCell(value: "1"),
        '3': PlutoCell(value: '2'),
        '4': PlutoCell(value: '3'),
      },
    ),
    PlutoRow(
      cells: {
        '1': PlutoCell(value: 'Buzzer'),
        '2': PlutoCell(value: "1"),
        '3': PlutoCell(value: '2'),
        '4': PlutoCell(value: '3'),
      },
    ),
    PlutoRow(
      cells: {
        '1': PlutoCell(value: 'Total'),
        '2': PlutoCell(value: "1"),
        '3': PlutoCell(value: '2'),
        '4': PlutoCell(value: '3'),
      },
    )
  ];
  final _columns = [
    PlutoColumn(
        enableColumnDrag: false,
        title: 'Round',
        field: '1',
        type: PlutoColumnType.text(),
        width: 100,
        suppressedAutoSize: true),
    PlutoColumn(
        enableColumnDrag: false,
        title: 'Correct',
        field: '2',
        width: 100,
        type: PlutoColumnType.text(),
        suppressedAutoSize: true),
    PlutoColumn(
        title: 'Wrong',
        enableColumnDrag: false,
        field: '3',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true),
    PlutoColumn(
        title: 'Total',
        enableColumnDrag: false,
        field: '4',
        type: PlutoColumnType.text(),
        suppressedAutoSize: true),
  ];
  @override
  void initState() {
    super.initState();
    correctNumber = widget.score / 10;
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    int correctNumberInt = correctNumber.toInt();

    setState(() {
      _controllerTopCenter.play();
    });

    return Scaffold(
      backgroundColor: const Color(0xff14154F),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 4.2 / 1.9,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Stack(children: [
                  Card(
                      color: Colors.teal[200],
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: PlutoGrid(
                              mode: PlutoGridMode.readOnly,
                              configuration: PlutoGridConfiguration(
                                style: PlutoGridStyleConfig(
                                  gridBackgroundColor: Colors.transparent,
                                  rowColor: Colors.transparent,
                                  borderColor: Colors.black,
                                  gridBorderColor: Colors.black,
                                  gridBorderRadius: BorderRadius.circular(12),
                                  //rowColor: btnColor,
                                  columnTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                  cellTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                  activatedBorderColor: Colors.black,
                                  enableGridBorderShadow: true,
                                ),
                              ),
                              onChanged: (PlutoGridOnChangedEvent event) {},
                              onLoaded: (PlutoGridOnLoadedEvent event) {},
                              noRowsWidget:
                                  const Center(child: Text('Scores will be!')),
                              columns: _columns,
                              rows: _rows),
                        ),
                      )),
                ]);
              },
            ),
          ),
          SlideTransition(
            position: _offsetAnimation2,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .25,
              height: context.height * 0.7,
              child: Column(
                children: [
                  const FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      "Congratulations!",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xffFFBA07),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: (0.05)),
                    child: CircleAvatar(
                      backgroundColor: const Color(0xff5A88B0),
                      radius: 120,
                      child: Image.asset("assets/icons/kupa.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FittedBox(
                      child: Text(
                        'Team Name'.tr,
                        style: const TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wrap(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                            backgroundColor: const Color(0xff5A88B0),
                            radius: 80,
                            child: getImageBuilder(
                                'https://d2qp0siotla746.cloudfront.net/img/use-cases/profile-picture/template_0.jpg')),
                        const Positioned(
                            bottom: 10,
                            left: 5,
                            child: Text(
                              'Muhammasd shahid',
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xff5A88B0),
                          radius: 80,
                          child: getImageBuilder(
                              'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'),
                        ),
                        const Positioned(
                            bottom: 10,
                            left: 5,
                            child: Text(
                              'Muhammasd shahid',
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _offsetAnimation1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xff5A88B0),
                          radius: 80,
                          child: getImageBuilder(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSR-dez27VzWPTKhNi5kQf-aNDxuBo1LQ1-Q&usqp=CAU'),
                        ),
                        const Positioned(
                            bottom: 10,
                            left: 5,
                            child: Text(
                              'Muhammasd shahid',
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                ),
                SlideTransition(
                  position: _offsetAnimation1,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xff5A88B0),
                          radius: 80,
                          child: getImageBuilder(
                              'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                        ),
                        const Positioned(
                            bottom: 10,
                            left: 5,
                            child: Text(
                              'Muhammasd shahid',
                              style: TextStyle(fontSize: 15),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            numberOfParticles: 100,
            blastDirectionality: BlastDirectionality.explosive,
            confettiController: _controllerTopCenter,
            shouldLoop:
                true, // start again as soon as the animation is finished
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
      ),
    );
  }

  getImageBuilder(url) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) =>
          CircularProgressIndicator(
        value: progress.progress,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
