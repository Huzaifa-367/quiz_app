import 'package:flutter/material.dart';
import 'package:quiz_app/screens/serverside/components/body.dart';

class ServerQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        //actions: const [],
      ),
      body: const Body(),
    );
  }
}
