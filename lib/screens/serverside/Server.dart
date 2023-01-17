import 'dart:io';

import 'package:flutter/foundation.dart';

class Server with ChangeNotifier {
  static String pressedBy = "-1";
  static String connectedIp = "";
  var connectedTeams = <Socket>[];
  static startListening() async {
    connectedIp = (InternetAddress.anyIPv4).address;
    var server = await ServerSocket.bind(InternetAddress.anyIPv4, 5000);
    server.listen((socket) {
      if (pressedBy == "-1") {
        socket.write('connected');
      }
      Server().handleTeam(socket);
    });
  }

  handleTeam(Socket team) {
    connectedTeams.add(team);
    try {
      team.listen(
        (Uint8List data) {
          pressedBy = String.fromCharCodes(data);
          broadCastMessage(data, team);
          notifyListeners();
        },
        onError: (error) {
          print(error);
          connectedTeams.remove(team);

          team.close();
        },
        onDone: () {
          connectedTeams.remove(team);
          team.close();
        },
      );
    } catch (e) {
      print(e);
    }
  }

  broadCastMessage(message, team) {
    try {
      for (var element in connectedTeams) {
        try {
          if (element != team) {
            element.write(message);
          }
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
