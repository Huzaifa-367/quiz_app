import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/serverside/dashboard.dart';

import 'components/body.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late String round = "";
  QuestionController controller = Get.put(QuestionController());
  @override
  void initState() {
    super.initState();
    controller.getQuestions(round);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            var c = Get.find<QuestionController>();
            c.allQuestions = [];

            Get.put(const DashBoard());
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
              onPressed: controller.nextQuestion,
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: const Body(),
    );
  }
}
