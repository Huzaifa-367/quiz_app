import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/serverside/result_Screen.dart';

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

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const ResultScreen(score: 1),
      //home: RestaurantList(restaurantList: cachedRestaurantList),
    );
  }
}
