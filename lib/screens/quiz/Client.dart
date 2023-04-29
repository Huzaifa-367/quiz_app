import 'dart:io';

//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';
import 'package:quiz_app/screens/welcome/Admin/AdminScreen.dart';

// import 'package:flutter_application_1/BuzzerScreen.dart';
// import 'package:flutter_application_1/Dialogues.dart';

class Client extends GetxController {
  RxBool isAdminConnected = false.obs;
  RxString id = "".obs;
  RxString pressedBy = "-1".obs;
  Rx<TextEditingController> ipController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  var controller = Get.find<QuestionController>();

  late Socket socket;
  late Stream broadCastStream;
  buzzerPressed(context) async {
    try {
      controller.ipAddress = ipController.value.text.trim();
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

  showStatus(data) async {
    id.value = String.fromCharCodes(data);
    Future.delayed(const Duration(microseconds: 100));
    //Get.back();
    if (id.value != 'Not found') {
      if (id.value.toLowerCase().contains("adm")) {
        Get.to(const AdminScreen());
      }
      Get.snackbar('', 'Successfully connected as ${id.value}',
          colorText: Colors.black);
    } else {
      id.value = "";
      Get.snackbar('can\'t connect...',
          'Make team exists by this name \n Or no one connected already');
    }
  }

  startListening() async {
    var q = Get.find<QuestionController>();
    try {
      if (nameController.value.text == "admin") {
        socket.write(nameController.value.text);
      } else {
        socket.write("${nameController.value.text}:");
      }
      socket.listen(
        (Uint8List data) {
          pressedBy.value = String.fromCharCodes(data);
          if (id.value == "") {
            showStatus(data);
          } else if (pressedBy.value.contains('mcq') ||
              pressedBy.value.contains('rapid') ||
              pressedBy.value.contains('buzzer')) {
            pressedBy.value = String.fromCharCodes(data);
            try {
              q.round = pressedBy.value.split(':')[0].trim();
              q.eventId = int.parse(pressedBy.value.split(':')[1].trim());

              if (!id.value.toString().startsWith('Adm')) {
                Get.back();
                Get.to(const QuizScreen());
              } else {
                controller.getQuestions("");
              }
            } catch (e) {
              printError(info: e.toString());
            }
          } else if (pressedBy.value.startsWith('#')) {
            var res = pressedBy.value.split('#').toList();
            q.questionNumber.value = int.parse(res[1]);
            // questionController.questions[0].opt1;
            if (nameController.value.text != "admin") {
              String option = res[1] == "1"
                  ? q.questions[int.parse(res[2]) - 1].opt1
                  : res[1] == "2"
                      ? q.questions[int.parse(res[2]) - 1].opt2
                      : res[1] == "3"
                          ? q.questions[int.parse(res[2]) - 1].opt3
                          : q.questions[int.parse(res[2]) - 1].opt4;
              q.checkAns(q.questions[int.parse(res[2]) - 1], option);
            }
          } else {
            try {
              pressedBy.value = String.fromCharCodes(data);
              if (pressedBy.value == "N") {
                q.questionNumber.value++;
                q.nextQuestion();
              } else if (pressedBy.value == "B") {
                q.questionNumber.value--;
                q.previousQuestion();
              } else if (pressedBy.value == "Sk") {
                q.questionNumber.value++;
                q.nextQuestion();
              } else if (pressedBy.value == "H") {
                //q.nextQuestion();
              } else {}
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
          // Get.showSnackbar(const GetSnackBar(
          //   titleText: Text('Disconnected'),
          // ));
          socket.close();
        },
        onDone: () {
          // connectedTeams.remove(team);
          // Get.showSnackbar(const GetSnackBar(
          //   titleText: Text('Disconnected'),
          // ));
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
