import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
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
          icon: Container(
            height: 40,
            width: 80,
            decoration: BoxDecoration(
              color: kGrayColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        //actions: const [],
      ),
      body: Obx(() =>
          teamController.connectedTeams.value == teamController.teams.length &&
                  teamController.connectedTeams.value != 0 &&
                  !isLoading
              ? Body(
                  round: widget.round,
                )
              : Center(child: getConnectingScreen())),
    );
  }

  Widget getConnectingScreen() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.6,
        width: MediaQuery.of(context).size.width / 1.62,
        color: const Color.fromARGB(255, 206, 198, 247).withOpacity(0.5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kGrayColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: FutureBuilder(
                  future: Client().getIp(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Listening at ip Address: ${snapshot.data.toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Wrap(
                  children: const [
                    Text(
                      'Waiting...',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.black,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Teams remaining : ${teamController.teams.length - teamController.connectedTeams.value} ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              width: 700,
              //color: Colors.amber,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: teamController.teams.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            teamController.teams[index].status.value ==
                                    'Pending'
                                ? Colors.red
                                : Colors.green,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            " ${teamController.teams[index].teamName} ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
