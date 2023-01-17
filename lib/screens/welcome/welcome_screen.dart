import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz/quiz_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  const Spacer(flex: 2), //2/6
                      GestureDetector(
                          child: Container(
                        alignment: Alignment.topCenter,
                        height: 190,
                        child: Text("Quiz App",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 80,
                                    wordSpacing: 2)),
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 50,
                          child: Text("Let's Play Quiz,",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                        ),
                      ),

                      GestureDetector(
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 50,
                          child: Text("Enter your informations below",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.black, fontSize: 20)),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      //const Spacer(), // 1/6
                      GestureDetector(
                          child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: const TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFF1C2341),
                            hintText: "Full Name",
                            hintStyle: TextStyle(fontSize: 23),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),
                      )),
                      // const Spacer(), // 1/6
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () => Get.to(QuizScreen()),
                        child: Container(
                          width: double.infinity,
                          // alignment: Alignment.center,
                          padding:
                              const EdgeInsets.all(kDefaultPadding * 1.5), // 15
                          decoration: const BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Text(
                            "Lets Start Quiz",
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .copyWith(color: Colors.black, fontSize: 30),
                          ),
                        ),
                      ),
                      // const Spacer(flex: 2), // it will take 2/6 spaces
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
