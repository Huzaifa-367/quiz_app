import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/TeamsController.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/Client.dart';
import 'package:quiz_app/screens/serverside/Server.dart';
import 'package:quiz_app/screens/serverside/components/body.dart';
import 'package:quiz_app/screens/serverside/dashboard.dart';

class ServerQuizScreen extends StatefulWidget {
  late String round;
  ServerQuizScreen(this.round);

  @override
  State<ServerQuizScreen> createState() => _ServerQuizScreenState();
}

class _ServerQuizScreenState extends State<ServerQuizScreen> {
  var serverController = Get.put(Server());
  var teamController = Get.put(TeamsController());
  @override
  void initState() {
    super.initState();
    getqus();
    getConnect();
  }

  getConnect() async {
    serverController.startListening();
  }

  QuestionController controller = Get.put(QuestionController());
  getqus() async {
    await controller.getQuestions(widget.round);

    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor=Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            var c = Get.find<QuestionController>();
            c.allQuestions = [];

            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const DashBoard();
              },
            ));
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        //actions: const [],
      ),
      body: teamController.connectedTeams.value ==
                  teamController.teams.length &&
              teamController.connectedTeams.value != 0 &&
              !isLoading
          ? Body(
              round: widget.round,
            )
          : Center(child: Obx(
              () {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 2,
                    color: Colors.black38,
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 30, top: 15),
                              child: FutureBuilder(
                                future: Client().getIp(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                        'Listening at ip Address: ${snapshot.data.toString()}');
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: teamController.teams.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: teamController
                                                .teams[index].status.value ==
                                            'Pending'
                                        ? Colors.red
                                        : Colors.green,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        teamController.teams[index].teamName,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              Wrap(
                                children: const [
                                  Text(
                                    'Waiting...',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircularProgressIndicator()
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  '${teamController.teams.length - teamController.connectedTeams.value} teams remaining',
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
    );
  }
}
