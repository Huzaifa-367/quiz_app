import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

import 'package:quiz_app/screens/quiz/components/option.dart';

import '../../../constants.dart';
import '../../../models/QuestionModel.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    Key? key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);
  var quesController = Get.find<QuestionController>();
  var clientController = Get.find<Client>();
  Question? question;
  Rx<Color> QBColor =
      const Color.fromARGB(255, 206, 198, 247).withOpacity(.6).obs;
  @override
  Widget build(BuildContext context) {
    QuestionController controller;
    try {
      controller = Get.find<QuestionController>();
    } catch (e) {
      controller = Get.put(QuestionController());
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                return GestureDetector(
                  onTap: () {
                    if (controller.round == 'buzzer') {
                      QBColor.value = const Color.fromARGB(255, 254, 180, 180)
                          .withOpacity(.6);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding),
                    padding: const EdgeInsets.all(kDefaultPadding * 0.9),
                    decoration: BoxDecoration(
                      color: QBColor.value,
                      border: Border.all(
                          color: const Color.fromARGB(255, 154, 182, 248)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      question!.ques,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: kDefaultPadding / 2),
            Option(
              index: 0,
              text: question!.opt1,
              press: () {
                if (!controller.isAnswered.value) {
                  clientController
                      .sendMessage("#1#${quesController.questionNumber.value}");
                  controller.checkAns(question!, question!.opt1);
                }
              },
            ),
            Option(
              index: 1,
              text: question!.opt2,
              press: () {
                if (!controller.isAnswered.value) {
                  clientController
                      .sendMessage("#2#${quesController.questionNumber.value}");
                  controller.checkAns(question!, question!.opt2);
                }
              },
            ),
            Option(
              index: 2,
              text: question!.opt3,
              press: () {
                if (!controller.isAnswered.value) {
                  clientController
                      .sendMessage("#3#${quesController.questionNumber.value}");
                  controller.checkAns(question!, question!.opt3);
                }
              },
            ),
            Option(
              index: 3,
              text: question!.opt4,
              press: () {
                if (!controller.isAnswered.value) {
                  clientController
                      .sendMessage("#4#${quesController.questionNumber.value}");
                  controller.checkAns(question!, question!.opt4);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
