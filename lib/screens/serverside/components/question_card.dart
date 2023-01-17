import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/models/Questions.dart';
import 'package:quiz_app/screens/quiz/components/option.dart';

import '../../../constants.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard({
    Key? key,
    // it means we have to pass this
    @required this.question,
  }) : super(key: key);

  Question? question;
  Color? QBColor = const Color.fromARGB(255, 206, 198, 247).withOpacity(.6);

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding * .52),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 206, 198, 247).withOpacity(0.3),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // QBColor =
                //     const Color.fromARGB(255, 254, 180, 180).withOpacity(.6);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .35,
                margin: const EdgeInsets.only(top: kDefaultPadding),
                padding: const EdgeInsets.all(kDefaultPadding * 0.6),
                decoration: BoxDecoration(
                  color: QBColor,
                  border: Border.all(
                      color: const Color.fromARGB(255, 154, 182, 248)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  question!.question!,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(width: kDefaultPadding),
            Container(
              width: MediaQuery.of(context).size.width * .45,
              margin: const EdgeInsets.only(top: kDefaultPadding),
              padding: const EdgeInsets.all(kDefaultPadding / 3.6),
              // decoration: BoxDecoration(
              //   color: const Color.fromARGB(255, 205, 220, 254),
              //   border:
              //       Border.all(color: const Color.fromARGB(255, 154, 182, 248)),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              child: Column(
                children: [
                  ...List.generate(
                    question!.options.length,
                    (index) => Option(
                      index: index,
                      text: question!.options[index],
                      press: () => controller.checkAns(question!, index),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
