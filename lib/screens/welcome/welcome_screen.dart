import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/screens/quiz/Client.dart';

class WelcomeScreen extends StatelessWidget {
  Client client = Get.find<Client>();

  WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    client.getIp();
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
                                .headlineMedium!
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
                                  .headlineMedium!
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
                                  .headlineMedium!
                                  .copyWith(color: Colors.black, fontSize: 20)),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      //const Spacer(),
                      // // 1/6
                      Obx(
                        () {
                          return getTextInputField(
                              client.nameController, 'Enter name');
                        },
                      ),

                      // const Spacer(), // 1/6
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () {
                          return getTextInputField(
                              client.ipController, 'Enter Ip');
                        },
                      ),

                      // const Spacer(), // 1/6
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          if (client.ipController.value.text != "" &&
                              client.nameController.value.text != "") {
                            Get.defaultDialog(
                                backgroundColor: Colors.black38,
                                barrierDismissible: false,
                                title: '',
                                content: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: const [
                                      Text('Trying to connect...'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircularProgressIndicator()
                                    ],
                                  ),
                                ));
                            await client.buzzerPressed(context);
                          } else if (client.nameController.value.text == "") {
                            Get.snackbar('', 'Please enter name',
                                colorText: Colors.black);
                          } else if (client.ipController.value.text == "") {
                            Get.snackbar('', 'Please enter ip Address',
                                colorText: Colors.black);
                          }
                        },
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
                                .labelLarge!
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
