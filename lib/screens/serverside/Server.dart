import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/TeamsController.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/models/TeamModel.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

class Server extends GetxController {
  RxString pressedBy = "-1".obs;
  static String connectedIp = "";
  var connectedTeams = <Socket>[];
  startListening() async {
    connectedIp = await Client().getIp();
    var server = await ServerSocket.bind(connectedIp, 5000);

    server.listen((socket) {
      Server().handleTeam(socket);
    });
  }

  var teamsController = Get.put(TeamsController());
  var questionController = Get.put(QuestionController());
  setTeam(name, Socket socket) {
    bool done = false;
    for (int i = 0; i < teamsController.teams.length; i++) {
      if (teamsController.teams[i].teamName
              .toLowerCase()
              .startsWith(name.toString().toLowerCase()) &&
          teamsController.teams[i].socket == null) {
        done = true;
        teamsController.teams[i].status.value = 'Connected';
        teamsController.teams[i].socket = socket;
        teamsController.connectedTeams.value++;
        if (teamsController.teams.length ==
            teamsController.connectedTeams.value) {
          broadCastMessage(questionController.round, '');
        }
        // Get.back();
        socket.write(teamsController.teams[i].teamName);
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
          if (!pressedBy.contains(':')) {
            broadCastMessage(data, player);
          } else {
            setTeam(pressedBy.split(':')[0], player);
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

  broadCastMessage(message, player) {
    try {
      for (var element in connectedTeams) {
        try {
          element.write(message);
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
