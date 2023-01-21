import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/controllers/TeamsController.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:quiz_app/models/QuestionModel.dart';
import 'package:quiz_app/models/TeamModel.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

String ip = '';
getQuestionss() async {
  ip = await Client().getIp();
  List<Question> questions = [];
  try {
    var contr = Get.find<EventController>();
    var response = await Dio().post(
        'http://$ip/ScoringAppServer/api/Question/GetQuestions?eventId=${contr.onGoingEvent!.id}');
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
  ip = await Client().getIp();
  List<eventss> events = [];
  try {
    var response =
        await Dio().get('http://$ip/ScoringAppServer/api/events/GetEvents');
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
  ip = await Client().getIp();
  try {
    var response =
        await Dio().post('http://$ip/ScoringAppServer/api/events/deleteEvent',
            data: e.toJson(),
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }));
    if (response.statusCode == 200) {
      Get.snackbar('Event', response.data);
      //return v.m
    }
  } catch (e) {
    print(e);
  }
}

getTeamsDetails() async {
  ip = await Client().getIp();
  var teams = Get.put(TeamsController());
  try {
    var v = Get.find<EventController>();

    var response = await Dio().post(
      'http://$ip/ScoringAppServer/api/teams/getTeamDetail?id=${v.onGoingEvent!.id}',
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
