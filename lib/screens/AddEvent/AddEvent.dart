import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import '../../controllers/ApisFunctions.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  String? eventtype;
  String? noOfTeams;
  TextEditingController dateTimeController =
      TextEditingController(text: "null");
  DateTime? dateTime = DateTime.now();
  List<String> events = ['Basic', 'Advance', 'Pro'];
  List<String> noteams = ['2', '3', '4'];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          //color: const Color.fromARGB(255, 177, 225, 202),
          width: context.width * 0.6,
          height: context.height * 0.7,

          child: Material(
            elevation: 1.0,
            color: const Color.fromARGB(255, 246, 246, 241),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 30, right: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add Event',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 300,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'select event type!';
                                }
                                return null;
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 246, 246, 241),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                hintText: 'Select Event Type',
                              ),
                              value: eventtype,
                              onChanged: (newValue) {
                                setState(() {
                                  eventtype = newValue;
                                });
                              },
                              items: events.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 300,
                            child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == '' || value == null) {
                                  return 'select total no.of teams!';
                                }
                                return null;
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 246, 246, 241),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                hintText: 'Select No Of Teams',
                              ),
                              value: noOfTeams,
                              onChanged: (newValue) {
                                setState(() {
                                  noOfTeams = newValue;
                                });
                              },
                              items: noteams.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FittedBox(
                      child: Container(
                        height: 50,
                        width: 600,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 245, 240, 227),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Pick Event Date",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                dateTime = await showRoundedDatePicker(
                                  description: 'Event date',
                                  context: context,
                                  initialDate: dateTime,
                                  borderRadius: 16,
                                );

                                setState(() {
                                  dateTimeController.text =
                                      dateTime.toString().split(' ')[0];
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color.fromARGB(255, 240, 227, 202),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: dateTimeController.text == "null"
                                      ? const Icon(
                                          Icons.calendar_month_rounded,
                                          color: Colors.black,
                                        )
                                      : Text(
                                          dateTimeController.text,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: careem,
                        fixedSize: const Size(150, 40),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          eventss e = eventss(
                              id: 0,
                              dates: dateTime.toString().split(' ')[0],
                              type: eventtype!,
                              status: 'created',
                              Tteams: int.parse(noOfTeams!));
                          await saveEvent(e);
                        }
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
