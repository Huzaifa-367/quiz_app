import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  TextEditingController dateTimeController = TextEditingController();
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
        child: Material(
          elevation: 1.0,
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.width * 0.6,
              height: context.height * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 30, right: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Add Event'),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'select event type!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'select type',
                        ),
                        value: eventtype,
                        onChanged: (newValue) {
                          setState(() {
                            eventtype = newValue;
                          });
                        },
                        items: events
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField(
                        validator: (value) {
                          if (value == '' || value == null) {
                            return 'select total no.of teams!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'select no of teams',
                        ),
                        value: noOfTeams,
                        onChanged: (newValue) {
                          setState(() {
                            noOfTeams = newValue;
                          });
                        },
                        items: noteams
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          dateTime = await showRoundedDatePicker(
                            description: 'Event date',
                            context: context,
                            initialDate: dateTime,
                            borderRadius: 16,
                          );
                          dateTimeController.text =
                              dateTime.toString().split(' ')[0];
                        },
                        child: TextFormField(
                          controller: dateTimeController,
                          enabled: false,
                          decoration: InputDecoration(
                              hintText:
                                  DateTime.now().toString().split(' ')[0]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 40)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              eventss e = eventss(
                                  id: 0,
                                  dates: dateTime.toString().split(' ')[0],
                                  type: eventtype!,
                                  status: 'Pending',
                                  Tteams: int.parse(noOfTeams!));
                              await saveEvent(e);
                            }
                          },
                          child: const Text('Add'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
