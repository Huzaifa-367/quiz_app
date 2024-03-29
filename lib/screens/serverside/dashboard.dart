import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/screens/serverside/result_Screen.dart';

import 'package:quiz_app/screens/serverside/widgets/eventcard.dart';
import 'package:quiz_app/screens/serverside/widgets/eventlist.dart';

import 'Server.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var controller;
  late Server serverController;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    controller = Get.find<EventController>();

    serverController = Get.find<Server>();

    getEvents();
  }

  getEvents() async {
    // await controller.getEventsList();
    //serverController.startListening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.18,
                    //width: MediaQuery.of(context).size.,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 250,
                          width: 250,
                          decoration: const BoxDecoration(
                              // color: Colors.black,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/SocietyLogo.png'))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.15),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.grey),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(218, 255, 255, 255)),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  suffixIcon: IconButton(
                                    color: Colors.grey,
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  hintText: 'Search an event...',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: SizedBox(
                              height: 40,
                              width: 140,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      const Color.fromARGB(255, 206, 198, 247)
                                          .withOpacity(.9),
                                ),
                                onPressed: (() {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return ServerQuizScreen();
                                  //   },
                                  // ));
                                }),
                                child: Text(
                                  "Recent",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CustomDivider(height: 40),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: SizedBox(
                              height: 40,
                              width: 140,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      const Color.fromARGB(255, 206, 198, 247)
                                          .withOpacity(.9),
                                ),
                                onPressed: (() {}),
                                child: Text(
                                  "Today's",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CustomDivider(height: 40),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: SizedBox(
                              height: 40,
                              width: 140,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  backgroundColor:
                                      const Color.fromARGB(255, 206, 198, 247)
                                          .withOpacity(.9),
                                ),
                                onPressed: (() {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const ResultScreen(score: 23);
                                    },
                                  ));
                                }),
                                child: Text(
                                  "Pending",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 26,
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: const RestaurantList()),
          SizedBox(
            height: 20,
            child: Obx(() => Text(
                  Get.find<EventController>()
                      .eventssList
                      .value
                      .length
                      .toString(),
                  style: const TextStyle(color: Colors.red),
                )),
          ),
        ],
      ),
    );
  }
}
