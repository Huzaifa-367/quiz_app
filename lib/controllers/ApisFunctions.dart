import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/EventsController.dart';
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

  controller = Get.find<QuestionController>();

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
  var teams = Get.find<TeamsController>();
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

saveEvent(eventss event) async {
  try {
    EventController eventController = Get.find<EventController>();
    var controller = Get.find<QuestionController>();
    var response = await Dio().post(
        'http://${controller.ipAddress}/ScoringAppApis/api/event/saveEvent',
        data: event.toJson(),
        options: Options(headers: {'Content-type': 'application/json'}));
    if (response.statusCode == 200) {
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        message: 'Added successfully',
        //titleText: Text('Added successfully'),
      ));

      eventController.eventssList.add(eventss.fromMap(response.data));

      print('s');
    } else {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        message: 'Failed to add',
      ));
    }
  } catch (e) {
    print(e);
  }
}
