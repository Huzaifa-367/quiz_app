import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/screens/quiz/Client.dart';
import 'package:quiz_app/screens/welcome/welcome_screen.dart';
import 'package:clay_containers/clay_containers.dart';

import '../../../constants.dart';
import '../../../controllers/question_controller.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var clientController = Get.find<Client>();
  var eventController = Get.find<EventController>();
  var quesController = Get.find<QuestionController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool started = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // backgroundColor=Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              var c = Get.find<QuestionController>();
              c.allQuestions = [];

              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return WelcomeScreen();
                },
              ));
            },
            icon: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                color: kGrayColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          // Fluttter show the back button automatically
          backgroundColor: Colors.transparent,
          elevation: 0,
          //actions: const [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
              child: Obx(() => !clientController.isAdminConnected.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              quesController.round.toString(),
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 20),
                            ),
                            Text.rich(
                                TextSpan(text: '', spellOut: true, children: [
                              TextSpan(
                                  text: quesController.questionNumber.value
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 20)),
                              TextSpan(
                                  text:
                                      "/${quesController.questions.value.length}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 20))
                            ])),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!started) ...{
                          ElevatedButton(
                              onPressed: () {
                                clientController.sendMessage("S");
                              },
                              child: const Text('Start')),
                          const SizedBox(
                            height: 20,
                          ),
                        } else ...{
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quesController.questionNumber.value > 0) {
                                    quesController.questionNumber.value--;
                                  }
                                  clientController.sendMessage("B");
                                },
                                child: ClayContainer(
                                  color: Colors.white54,
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  customBorderRadius: const BorderRadius.only(
                                      bottomRight: Radius.elliptical(150, 150),
                                      topLeft: Radius.circular(50)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      //right: 10
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (quesController.questionNumber.value <
                                      quesController.questions.value.length) {
                                    quesController.questionNumber.value++;
                                  }
                                  clientController.sendMessage("N");
                                },
                                child: ClayContainer(
                                  color: Colors.white54,
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  customBorderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.elliptical(150, 150),
                                      topRight: Radius.circular(50)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      //left: 10
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //quesController.questionNumber.value++;
                                  clientController.sendMessage("H");
                                },
                                child: ClayContainer(
                                  color: Colors.white54,
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  customBorderRadius: const BorderRadius.only(
                                      topRight: Radius.elliptical(150, 150),
                                      bottomLeft: Radius.circular(50)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0, // right: 10
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Hide',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (quesController.questionNumber.value <
                                      quesController.questions.value.length) {
                                    quesController.questionNumber.value++;
                                  }
                                  clientController.sendMessage("Sk");
                                },
                                child: ClayContainer(
                                  color: Colors.white54,
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  customBorderRadius: const BorderRadius.only(
                                      topLeft: Radius.elliptical(150, 150),
                                      bottomRight: Radius.circular(50)),
                                  child: const Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.0,
                                      // left: 10
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Skip',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          ),

                          // ElevatedButton(
                          //     onPressed: () {
                          //       clientController.sendMessage("N");
                          //     },
                          //     child: const Text('Next')),
                          // const SizedBox(
                          //   height: 22,
                          // ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       clientController.sendMessage("B");
                          //     },
                          //     child: const Text('Back')),
                          // const SizedBox(
                          //   height: 21,
                          // ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       clientController.sendMessage("S");
                          //     },
                          //     child: const Text('Skip')),
                        }
                      ],
                    )
                  : const Text('Disconnected'))),
        ));
  }
}
