import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/screens/quiz/Client.dart';
import 'package:quiz_app/screens/serverside/Server.dart';
import 'package:quiz_app/screens/serverside/dashboard.dart';

import 'controllers/EventsController.dart';
import 'controllers/TeamsController.dart';
import 'controllers/question_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      onInit: () {
        Get.put(TeamsController());
        Get.put(EventController());
        Get.put(QuestionController());
        Get.put(Client());
        Get.put(Server());
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const DashBoard(),
      //home: RestaurantList(restaurantList: cachedRestaurantList),
    );
  }
}
