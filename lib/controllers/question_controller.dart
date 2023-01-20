import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/ApisFunctions.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/models/QuestionModel.dart' as q;
import 'package:quiz_app/screens/score/score_screen.dart';

import 'TeamsController.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with GetTickerProviderStateMixin {
  // Lets animated our progress bar

  AnimationController? animationController;
  Animation? _animation;
  String? round;
  // so that we can access our animation outside
  Animation get animation => _animation!;

  late PageController _pageController;
  PageController get pageController => _pageController;
  // static int ongoingEventId = 7;

  late List<q.Question> questions = [];

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  late String _correctAns;
  String get correctAns => _correctAns;

  late String _selectedAns;
  String get selectedAns => _selectedAns;
  List<q.Question> allQuestions = [];
  getQuestions(round) async {
    if (allQuestions.isEmpty) {
      allQuestions = await getQuestionss();
      await TeamsController().getTeamsDetail();
    }
    if (round == 'rapid') {
      animationController!.duration = const Duration(seconds: 120);
    } else if (round == 'buzzer') {
      animationController!.duration = const Duration(seconds: 5);
    }
    questions = allQuestions
        .where(
            (element) => element.type.toLowerCase().contains(round.toString()))
        .toList();
  }

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  late int eventId = 0;

  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // called immediately after the widget is allocated memory

  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    animationController = AnimationController(
        duration: Duration(seconds: round != 'rapid' ? 60 : 120), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(animationController!)
      ..addListener(() {
        // update like setState
        update();
      });
    // start our animation
    // Once 60s is completed go to the next qn
    if (animationController != null) {
      animationController!.reverse().whenComplete(nextQuestion);
    }
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    if (animationController != null) {
      animationController!.dispose();
    }
    _pageController.dispose();
  }

  void checkAns(q.Question question, String selectedIndex) {
    // because once user press any option then it will run
    _isAnswered = true;
    _correctAns = question.answer.trim();
    _selectedAns = selectedIndex.trim();

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    if (animationController != null) {
      animationController!.stop();
    }
    update();

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      animationController!.reset();

      // Then start it again
      // Once timer is finish go to the next
      animationController!.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  var eventController = Get.find<EventController>();
  var teamController = Get.put(TeamsController());
  void updateTheQnNum(int index) async {
    if (round == 'mcq') {
      eventController.teamName.value =
          teamController.teams[eventController.team].teamName.toString();
      if (eventController.onGoingEvent!.Tteams! - 1 > eventController.team) {
        eventController.team++;
      } else {
        eventController.team = 0;
      }
    } else if (round == 'rapid') {
      if (_questionNumber.value <= 2) {
        eventController.teamName.value =
            teamController.teams[0].teamName.toString();
      }
      if (_questionNumber.value == questions.length / 2) {
        animationController!.stop();
        await Get.defaultDialog(
            confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Ok')),
            content: const Text('Press ok to continue for next team'));
        animationController!.repeat();
        eventController.teamName.value =
            teamController.teams[1].teamName.toString();
      }
    }
    _questionNumber.value = index + 1;
  }
}
