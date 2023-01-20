import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/serverside/components/body.dart';
import 'package:quiz_app/screens/serverside/dashboard.dart';

class ServerQuizScreen extends StatelessWidget {
  late String round;
  ServerQuizScreen(this.round);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            var c = Get.find<QuestionController>();
            c.allQuestions = [];

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const DashBoard();
              },
            ));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        //actions: const [],
      ),
      body: Body(
        round: round,
      ),
    );
  }
}
