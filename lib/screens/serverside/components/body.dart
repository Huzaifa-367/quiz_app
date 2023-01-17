import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';

import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    // So that we have acccess our controller
    QuestionController questionController = Get.put(QuestionController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ProgressBar(),
            ),
            const SizedBox(height: kDefaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Obx(
                    () => Text.rich(
                      TextSpan(
                        text:
                            "Question ${questionController.questionNumber.value}",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: kSecondaryColor),
                        children: [
                          TextSpan(
                            text: "/${questionController.questions.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: kSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:
                            const Color.fromARGB(255, 206, 198, 247)
                                .withOpacity(.9),
                      ),
                      onPressed: controller.nextQuestion,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: [
                SizedBox(
                  height: 420,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: PageView.builder(
                    // Block swipe to next qn
                    physics: const NeverScrollableScrollPhysics(),
                    controller: questionController.pageController,
                    onPageChanged: questionController.updateTheQnNum,
                    itemCount: questionController.questions.length,
                    itemBuilder: (context, index) => QuestionCard(
                        question: questionController.questions[index]),
                  ),
                ),
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 206, 198, 247)
                                  .withOpacity(0.3),
                          radius: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {},
                              child: const Expanded(
                                child: Text(
                                  "Player 1",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 206, 198, 247)
                                  .withOpacity(0.3),
                          radius: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {},
                              child: const Expanded(
                                child: Text(
                                  "Player 2",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
