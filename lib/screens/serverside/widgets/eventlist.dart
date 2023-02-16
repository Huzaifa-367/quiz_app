import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/controllers/EventsController.dart';
import 'package:quiz_app/controllers/question_controller.dart';
//import 'package:quiz_app/screens/serverside/Model/Events.dart';
import 'package:quiz_app/screens/serverside/widgets/eventcard.dart';
import 'package:quiz_app/screens/serverside/widgets/que_screen.dart';

class RestaurantList extends StatefulWidget {
  //final List<eventss> restaurantList;

  const RestaurantList({
    Key? key,
    // required this.restaurantList,
  }) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  var controller = Get.find<EventController>();
  var c = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: FutureBuilder(
        future: controller.getEventsList(),
        // init: controller,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: controller.eventssList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1 / 0.8,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 0),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: const Color.fromARGB(255, 80, 217, 158)
                          .withOpacity(0.3),
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        child: Container(
                          height: 260,
                          width: 220,
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 400,
                                  child: AspectRatio(
                                    aspectRatio: 1.8,
                                    child: Image.asset(
                                      "assets/icons/testing.jpeg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Add An Event!",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Save an event to Start...",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Material(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: EventCard(
                    onTap: () async {
                      await showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                                const Color.fromARGB(255, 206, 198, 247)
                                    .withOpacity(.9),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: (() {
                                        Navigator.of(context).pop();
                                      }),
                                      icon: const Icon(
                                        color: Colors.black,
                                        Icons.cancel_outlined,
                                      ),
                                    ),
                                  ],
                                ),
                                getOptionWidget('MCQ', index),
                                getOptionWidget('Rapid', index),
                                getOptionWidget('Buzzer', index),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SizedBox(
                                    height: 50,
                                    width: 160,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 5,
                                        backgroundColor: const Color.fromARGB(
                                            218, 255, 255, 255),
                                      ),
                                      onPressed: (() {
                                        // Navigator.push(context, MaterialPageRoute(
                                        //   builder: (context) {
                                        //     return ServerQuizScreen();
                                        //   },
                                        // ));
                                      }),
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    backgroundColor:
                        Colors.primaries[index % Colors.primaries.length],
                    restaurant: controller.eventssList[index - 1],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something gone wrong'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  getOptionWidget(String text, index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        width: 160,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: const Color.fromARGB(218, 255, 255, 255),
          ),
          onPressed: (() {
            c.round = text.toLowerCase();

            c.eventId = controller.eventssList[index].id;
            controller.onGoingEvent = controller.eventssList[index];
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return ServerQuizScreen(text.toLowerCase());
              },
            ));
          }),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
