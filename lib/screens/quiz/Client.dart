import 'dart:convert';
import 'dart:io';

//import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/BuzzerScreen.dart';
// import 'package:flutter_application_1/Dialogues.dart';

class Client {
  static String? id;
  static String pressedBy = "-1";

  static late Socket socket;
  static late Stream broadCastStream;
  static buzzerPressed(context) async {
    try {
      //String ip = await getIp();
      //socket = await Socket.connect(MyHomePage.ipController.text.trim(), 5000);

      broadCastStream = socket.asBroadcastStream();
      // Dialogue.getWaiting(
      //     context, "", 'Waiting for others to join...', DialogType.info);

      utf8.decode(await broadCastStream.first);
      //id = MyHomePage.nameController.text;

      if (id != null) {
        // Navigator.pushReplacement(context, MaterialPageRoute(
        //   builder: (context) {
        //     return const BuzzerScreen();
        //   },
        // ));
      }
      // Read data from the server
      //MyHomePage.isPressed = false;
    } catch (ex) {
      //Navigator.pop(context);
      // Dialogue.getWaiting(
      //     context, "", 'Something gone wrong...', DialogType.error);
      // MyHomePage.isPressed = false;
    }
  }

  getIp(context) async {
    try {
      // Get a list of network interfaces
      List<NetworkInterface> interfaces = await NetworkInterface.list();

      // Loop through the interfaces
      for (NetworkInterface ni in interfaces) {
        // Check if the interface is a WiFi interface
        if (ni.name.startsWith('wlan')) {
          // Get the gateway address of the WiFi interface
          List<InternetAddress> addresses = ni.addresses;
          for (InternetAddress address in addresses) {
            //  MyHomePage.ipController.text = address.address;
          }
        }
      }
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not load IP address.\nTry Again')));
    }
  }
}
