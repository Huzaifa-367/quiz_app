import 'dart:io';

//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';

// import 'package:flutter_application_1/BuzzerScreen.dart';
// import 'package:flutter_application_1/Dialogues.dart';

class Client extends GetxController {
  RxString id = "".obs;
  RxString pressedBy = "-1".obs;
  Rx<TextEditingController> ipController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;

  late Socket socket;
  late Stream broadCastStream;
  buzzerPressed(context) async {
    try {
      // String ip = await getIp(context);
      socket = await Socket.connect(ipController.value.text.trim(), 5000);
      startListening();

      // Read data from the server
      //MyHomePage.isPressed = false;
    } catch (ex) {
      Get.back();
      Get.snackbar('', 'Something gone wrong...', colorText: Colors.black);
      //Navigator.pop(context);
      // Dialogue.getWaiting(
      //     context, "", 'Something gone wrong...', DialogType.error);
      // MyHomePage.isPressed = false;
    }
  }

  sendMessage(message) {
    try {
      socket.write(message);
    } catch (e) {
      printError(info: e.toString());
    }
  }

  startListening() async {
    var q = Get.put(QuestionController());
    try {
      socket.write("${nameController.value.text}:");
      socket.listen(
        (Uint8List data) {
          if (id.value == "") {
            id.value = String.fromCharCodes(data);
            //Get.back();
            if (id.value != 'Not found') {
              Get.snackbar('', 'Successfully connected as ${id.value}',
                  colorText: Colors.black);
            } else {
              id.value = "";
              Get.snackbar('can\'t connect...',
                  'Make team exists by this name \n Or no one connected already');
            }
          } else if (pressedBy.value.contains('mcq') ||
              pressedBy.value.contains('rapid') ||
              pressedBy.value.contains('buzzer')) {
            pressedBy.value = String.fromCharCodes(data);

            try {
              q.round = pressedBy.value;

              q.eventId = int.parse(pressedBy.value.split(':')[1].trim());
              Get.to(QuizScreen());
            } catch (e) {
              printError(info: e.toString());
            }
          } else {
            try {
              pressedBy.value = String.fromCharCodes(data);
              q.questionNumber.value = int.parse(pressedBy.value);
            } catch (e) {
              printError(info: e.toString());
            }
          }
          //broadCastMessage(data, team);
          // notifyListeners();
        },
        onError: (error) {
          print(error);
          //connectedTeams.remove(team);

          socket.close();
        },
        onDone: () {
          // connectedTeams.remove(team);
          socket.close();
        },
      );
    } catch (e) {
      printError(info: e.toString());
    }
  }

  getIp() async {
    try {
      // Get a list of network interfaces
      List<NetworkInterface> interfaces = await NetworkInterface.list();

      // Loop through the interfaces
      for (NetworkInterface ni in interfaces) {
        // Check if the interface is a WiFi interface
        if (ni.name.startsWith('Wi')) {
          // Get the gateway address of the WiFi interface
          List<InternetAddress> addresses = ni.addresses;
          for (InternetAddress address in addresses) {
            ipController.value.text = address.address;
          }
        }
      }
    } catch (ex) {
      Get.snackbar('', 'Could not load IP address.\nTry Again');
    }
    return ipController.value.text;
  }
}
