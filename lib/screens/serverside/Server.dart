import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/controllers/TeamsController.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/models/TeamModel.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

class Server extends GetxController {
  RxString pressedBy = "-1".obs;
  Socket? adminSocket;
  static String connectedIp = "";
  var connectedTeams = <Socket>[];
  startListening() async {
    try {
      connectedIp = await Client().getIp();
      var server = await ServerSocket.bind(connectedIp, 5000);

      server.listen((socket) {
        handleTeam(socket);
      });
    } catch (e) {
      print(e);
    }
  }

  var teamsController = Get.put(TeamsController());
  var questionController = Get.put(QuestionController());
  var eventController = Get.put(EventController());
  setTeam(name, Socket socket) {
    bool done = false;
    for (int i = 0; i < teamsController.teams.length; i++) {
      if (teamsController.teams[i].teamName
              .toLowerCase()
              .startsWith(name.toString().toLowerCase()) &&
          teamsController.teams[i].socket == null) {
        socket.write(teamsController.teams[i].teamName);
        done = true;
        teamsController.teams[i].status.value = 'Connected';
        teamsController.teams[i].socket = socket;
        teamsController.connectedTeams.value++;

        if (teamsController.teams.length ==
            teamsController.connectedTeams.value) {
          Future.delayed(const Duration(seconds: 5)).then((value) {
            broadCastMessage(
                '${questionController.round!}:${questionController.eventId}',
                '');
          });
        }
        // Get.back();
      }
    }
    if (!done) {
      socket.write('Not found');
    }
  }

  handleTeam(Socket player) {
    connectedTeams.add(player);
    try {
      player.listen(
        (Uint8List data) {
          pressedBy.value = String.fromCharCodes(data);
          if (pressedBy.value == "admin") {
            adminSocket = player;
            player.write("Admin");
            Future.delayed(const Duration(seconds: 2)).then((value) => {
                  player.write(
                      '${questionController.round!}:${questionController.eventId}')
                });

            if (teamsController.teams.length ==
                teamsController.connectedTeams.value) {
              Future.delayed(const Duration(seconds: 3)).then((value) {
                broadCastMessage(
                    '${questionController.round!}:${questionController.eventId}',
                    '');
              });
            }
          } else if (teamsController.teams.length !=
              teamsController.connectedTeams.value) {
            setTeam(pressedBy.split(':')[0], player);
          } else if (pressedBy.value.startsWith('#')) {
            var res = pressedBy.value.split('#').toList();

            // questionController.questions[0].opt1;
            String option = res[1] == "1"
                ? questionController.questions.value[int.parse(res[2]) - 1].opt1
                : res[1] == "2"
                    ? questionController.questions[int.parse(res[2]) - 1].opt2
                    : res[1] == "3"
                        ? questionController
                            .questions[int.parse(res[2]) - 1].opt3
                        : questionController
                            .questions[int.parse(res[2]) - 1].opt4;
            questionController.checkAns(
                questionController.questions[int.parse(res[2]) - 1], option);
          } else if (!pressedBy.contains(':')) {
            broadCastMessage(pressedBy.value, player);
            Future.delayed(const Duration(seconds: 1)).then((value) => {
                  if (pressedBy.value == "N")
                    {
                      questionController.questionNumber.value++,
                      questionController.updateTheQnNum(),
                      questionController.nextQuestion()
                    }
                  else if (pressedBy.value == "B")
                    {
                      questionController.questionNumber.value--,
                      questionController.updateTheQnNum(),
                      questionController.previousQuestion()
                    }
                  else if (pressedBy.value == "Sk")
                    {
                      questionController.questionNumber.value++,
                      questionController.updateTheQnNum(),
                      questionController.nextQuestion()
                    }
                  else if (pressedBy.value == "H")
                    {
                      questionController.playCorrectSong()
                      //questionController.nextQuestion()
                    }
                  // else
                  //   {
                  //     if (teamsController.teams
                  //         .where((element) =>
                  //             element.teamName == pressedBy.value.trim())
                  //         .isEmpty)
                  //       {
                  //         questionController.checkAns(
                  //             questionController.questions[
                  //                 questionController.questionNumber.value],
                  //             pressedBy.value.split(':')[0])
                  //       }
                  //     else
                  //       {
                  //         eventController.teamName.value =
                  //             pressedBy.value.trim()
                  //       }
                  //   }
                });
          }
          //notifyListeners();
        },
        onError: (error) {
          print(error);
          team t = teamsController.teams
              .where((element) => element.socket == player)
              .first;
          setDefault(t);
          connectedTeams.remove(player);

          player.close();
        },
        onDone: () {
          team t = teamsController.teams
              .where((element) => element.socket == player)
              .first;
          setDefault(t);
          connectedTeams.remove(player);
          player.close();
        },
      );
    } catch (e) {
      print(e);
    }
  }

  setDefault(player) {
    for (int i = 0; i < teamsController.teams.length; i++) {
      if (teamsController.teams[i] == player) {
        teamsController.teams[i].status.value = 'Pending';
        teamsController.teams[i].socket = null;
        teamsController.connectedTeams.value--;
      }
    }
  }

  sendMesage(element, message) async {
    try {
      element.socket!.write(message);
      Future.delayed(const Duration(microseconds: 10));
    } catch (e) {
      print(e);
    }
  }

  broadCastMessage(message, player) {
    try {
      //adminSocket!.write(message);
      for (var element in teamsController.teams) {
        sendMesage(element, message);
        try {} catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
