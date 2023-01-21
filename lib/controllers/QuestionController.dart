import 'package:flutter/material.dart';
import 'package:quiz_app/controllers/ApisFunctions.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:quiz_app/models/QuestionModel.dart';
import 'package:quiz_app/screens/score/score_screen.dart';

class QuestionControllerProvider with ChangeNotifier {
  List<Question> questions = [];
  int eventId = 0;
  int index = 0;
  AnimationController? _animationController;
  Animation? _animation;
  // so that we can access our animation outside
  Animation get animation => _animation!;

  late PageController _pageController;
  PageController get pageController => _pageController;
  String? selectedAnswer = "";
  static eventss? onGoingEvent;
  getQuestions() async {
    try {
      questions = await getQuestionss();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  int isCorrect = -1;
  bool isTrue = false;
  checkAnswer(option, context) {
    try {
      if (selectedAnswer!.trim() == questions[index].answer.trim()) {
        isCorrect = option;
        isTrue = true;
      } else {
        isCorrect = option;
        isTrue = false;
      }
      if (_animationController != null) {
        _animationController!.stop();
      }

      // Once user select an ans after 3s it will go to the next qn
      Future.delayed(const Duration(seconds: 3), () {
        nextQuestion(context);
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void nextQuestion(context) {
    if (index != questions.length) {
      //_isAnswered = false;
      selectedAnswer = "";
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
      index++;
      // Reset the counter
      _animationController!.reset();

      // Then start it again
      // Once timer is finish go to the next
      _animationController!.forward().whenComplete(() {
        nextQuestion(context);
      });
    } else {
      // Get package provide us simple way to naviigate another page
      // Get.to(ScoreScreen());
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ScoreScreen();
        },
      ));
    }
  }
}
