import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/ApisFunctions.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/models/QuestionModel.dart' as q;
import 'package:quiz_app/screens/score/score_screen.dart';
import 'TeamsController.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io' show Platform;
// We use get package for our state management

class QuestionController extends GetxController
    with GetTickerProviderStateMixin {
  // Lets animated our progress bar

  AnimationController? animationController;
  Animation? _animation;
  final AudioPlayer _assetsAudioPlayer = AudioPlayer();
  String? round;
  // so that we can access our animation outside
  Animation get animation => _animation!;
  String ipAddress = "";
  late PageController _pageController;
  PageController get pageController => _pageController;
  // static int ongoingEventId = 7;
  Rx<Color> progressColor = Colors.green.obs;
  late RxList questions = [].obs;
  RxBool isOptionsDisabled = false.obs;
  final RxBool _isAnswered = false.obs;
  RxBool get isAnswered => _isAnswered;

  late String _correctAns;
  String get correctAns => _correctAns;

  late String _selectedAns;
  String get selectedAns => _selectedAns;
  List<q.Question> allQuestions = [];
  getQuestions(r) async {
    if (allQuestions.isEmpty) {
      allQuestions = await getQuestionss(eventId);
      await TeamsController().getTeamsDetail();
    }
    if (round == 'rapid') {
      animationController!.duration = const Duration(seconds: 120);
    } else if (round == 'buzzer') {
      animationController!.duration = const Duration(seconds: 5);
    }
    questions.value = allQuestions
        .where(
            (element) => element.type.toLowerCase().contains(round.toString()))
        .toList();
  }

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  late int eventId = 0;

  RxInt get questionNumber => _questionNumber;

  final int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // called immediately after the widget is allocated memory

  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    animationController = AnimationController(
        duration: Duration(seconds: round != 'rapid' ? 60 : 120), vsync: this)
      ..addListener(() {
        if (animationController!.value == 10 && Platform.isWindows) {
          playTimerSound();
        }
        if (animationController!.value == 10) {
          progressColor.value = Colors.red;
        } else if (animationController!.duration!.inSeconds / 2 ==
            animationController!.value) {
          progressColor.value = Colors.amberAccent[700]!;
        }
      });
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
    _isAnswered.value = true;
    _correctAns = question.answer.trim();
    _selectedAns = selectedIndex.trim();
    if (animationController != null) {
      animationController!.stop();
    }
    update();
    if (_correctAns == _selectedAns) {
      playCorrectSong();
      if (round == 'rapid') {
        teamController.teams[eventController.team].rapidRound =
            teamController.teams[eventController.team].rapidRound! + 1;
      } else if (round == 'buzzer') {
        teamController.teams[eventController.team].buzzerRound =
            teamController.teams[eventController.team].buzzerRound! + 1;
      } else if (round == 'mcq') {
        teamController.teams[eventController.team].mcqRound =
            teamController.teams[eventController.team].mcqRound! + 1;
      }
    } else if (round == 'buzzer') {
      playWrongSong();
      teamController.teams[eventController.team].buzzerWrong =
          teamController.teams[eventController.team].buzzerWrong! + 1;
    } else {
      playWrongSong();
    }

    // It will stop the counter

    // Once user select an ans after 3s it will go to the next qn
    // Future.delayed(const Duration(seconds: 3), () {
    //   nextQuestion();
    // });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      isOptionsDisabled.value = false;
      _isAnswered.value = false;
      progressColor.value = Colors.green;
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);

      // Reset the counter
      if (round == 'rapid') {
        // animationController!.reset();
        animationController!.forward().whenComplete(nextQuestion);
      } else if (round == 'buzzer') {
        animationController!.reset();
        animationController!.stop();
      } else {
        animationController!.reset();
        if (Platform.isWindows) {
          animationController!.forward().whenComplete(nextQuestion);
        } else {
          animationController!.forward().whenComplete(() {
            isOptionsDisabled.value = true;
          });
        }
      }
      // Then start it again
      // Once timer is finish go to the next
    } else {
      // Get package provide us simple way to naviigate another page
      Get.to(ScoreScreen());
    }
  }

  playWrongSong() {
    //_assetsAudioPlayer.open(Audio("assets/icons/Songs/Wrong.wav"));
    _assetsAudioPlayer.play(AssetSource('icons/Songs/Wrong.wav'));
  }

  playCorrectSong() {
    _assetsAudioPlayer.play(
      AssetSource('icons/Songs/correct.wav'),
      //volume: 100
    );
    // _assetsAudioPlayer.open(Audio("assets/icons/Songs/correct.wav"));
    // _assetsAudioPlayer.play();
  }

  playBuzzer() {}
  playBuzzerPressed() {
    // _assetsAudioPlayer.open(Audio("assets/icons/Songs/BuzzerPressed.wav"));
    // _assetsAudioPlayer.play();
  }

  playTimerSound() {
    _assetsAudioPlayer.play(AssetSource("icons/Songs/countDown.wav"));
  }

  previousQuestion() {
    if (_questionNumber.value >= 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  var eventController = Get.put(EventController());
  var teamController = Get.put(TeamsController());
  void updateTheQnNum() async {
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
        eventController.team = 0;
        eventController.teamName.value =
            teamController.teams[0].teamName.toString();
      }
      if (_questionNumber.value == questions.length / 2) {
        eventController.team++;
        animationController!.stop();
        await Get.defaultDialog(
            confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Ok')),
            content: const Text('Press ok to continue for next team'));
        animationController!.reset();
        animationController!.repeat();
        eventController.teamName.value =
            teamController.teams[1].teamName.toString();
      }
    }
  }
}
