import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/welcome/welcome_screen.dart';

import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String round = "";
  late QuestionController controller;
  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find<QuestionController>();
    } catch (e) {
      controller = Get.put(QuestionController());
    }
    getQuestions();
  }

  getQuestions() async {
    await controller.getQuestions(round);
    isLoading.value = false;
  }

  RxBool isLoading = true.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() => !isLoading.value
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  var c = Get.find<QuestionController>();
                  c.allQuestions = [];

                  Get.put(WelcomeScreen());
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              // Fluttter show the back button automatically
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: const [
                // if (controller.round!.contains("buz"))
                //   TextButton(
                //       onPressed: controller.nextQuestion,
                //       child: const Text(
                //         "Skip",
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: Colors.white,
                //         ),
                //       )),
              ],
            ),
            body: const Body(),
          )
        : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
