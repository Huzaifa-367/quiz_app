import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/TeamsController.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:quiz_app/models/QuestionModel.dart';
import 'package:quiz_app/models/TeamModel.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

String ip = '';
getQuestionss(eventId) async {
  var controller = Get.find<QuestionController>();
  if (controller.ipAddress == "") {
    controller.ipAddress = await Client().getIp();
  }
  List<Question> questions = [];
  try {
    //var contr = Get.find<EventController>();
    var response = await Dio().get(
        'http://${controller.ipAddress}/ScoringAppApis/api/event/getQuestions?event_id=$eventId');
    if (response.statusCode == 200) {
      for (var element in response.data) {
        questions.add(Question.fromMap(element));
      }
      //return v.m
    }
  } catch (e) {
    print(e);
  }
  return questions;
}

getEventsLists() async {
  QuestionController controller;
  try {
    controller = Get.find<QuestionController>();
  } catch (e) {
    controller = Get.put(QuestionController());
  }
  if (controller.ipAddress == "") {
    controller.ipAddress = await Client().getIp();
  }
  List<eventss> events = [];
  try {
    var url =
        'http://${controller.ipAddress}/ScoringAppApis/api/event/GetEvents';
    var response = await Dio().get(url);
    if (response.statusCode == 200) {
      for (var element in response.data) {
        events.add(eventss.fromMap(element));
      }
      //return v.m
    }
  } catch (e) {
    print(e);
  }
  return events;
}

deleteEvent(eventss e) async {
  var controller = Get.find<QuestionController>();
  if (controller.ipAddress == "") {
    controller.ipAddress = await Client().getIp();
  }
  try {
    var response = await Dio().get(
      'http://${controller.ipAddress}/ScoringAppApis/api/event/deleteEvent?event_id=${e.id}',
    );
    if (response.statusCode == 200) {
      Get.snackbar('Event', response.data);
      //return v.m
    }
  } catch (e) {
    print(e);
  }
}

getTeamsDetails() async {
  var controller = Get.find<QuestionController>();
  if (controller.ipAddress == "") {
    controller.ipAddress = await Client().getIp();
  }
  var teams = Get.put(TeamsController());
  try {
    var v = Get.find<QuestionController>();

    var response = await Dio().get(
      'http://${controller.ipAddress}/ScoringAppApis/api/event/getTeamDetail?event_id=${v.eventId}',
    );
    if (response.statusCode == 200) {
      //Get.snackbar('Event', response.data);
      teams.teams.clear();
      for (var element in response.data) {
        //return v.m
        teams.teams.add(team.fromMap(element));
      }
    }
  } catch (e) {
    print(e);
  }
  return teams.teams;
}
