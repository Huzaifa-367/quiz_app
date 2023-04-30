import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:quiz_app/models/memberModel.dart';

class AddMembersScreen extends StatefulWidget {
  eventss event;
  AddMembersScreen({super.key, required this.event});

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  TextEditingController teamName = TextEditingController();
  String? noOfteams;
  TextEditingController memberName = TextEditingController();
  TextEditingController regNo = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<String> noteams = ['1', '2', '3', '4', '5'];
  List<MemberDetail> membersAdded = [];
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.event.type,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 600,
                  width: 400,
                  color: const Color.fromARGB(255, 240, 227, 202),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 28.0,
                        right: 28.0,
                        top: 15.0,
                        bottom: 28.0,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Team Details',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          getTextInputField1(teamName, 'Enter team name'),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField(
                            validator: (value) {
                              if (value == '' || value == null) {
                                return 'select event type!';
                              }
                              return null;
                            },
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
                              hintText: 'select no of members',
                            ),
                            value: noOfteams,
                            onChanged: (newValue) {
                              setState(() {
                                noOfteams = newValue;
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
                            height: 10,
                          ),
                          const Text(
                            "Member' s Detail",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          getTextInputField1(memberName, 'Enter name'),
                          const SizedBox(
                            height: 10,
                          ),
                          getTextInputField1(regNo, 'Enter Regno'),
                          const SizedBox(
                            height: 10,
                          ),
                          getTextInputField1(phone, 'Enter phone'),
                          const SizedBox(
                            height: 10,
                          ),
                          getTextInputField1(semester, 'Enter semester'),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: careem,
                              fixedSize: const Size(150, 40),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.red,
                  thickness: 12,
                  width: 32,
                ),
                SizedBox(
                  height: 600,
                  width: 500,
                  // color: const Color.fromARGB(255, 116, 95, 31),
                  child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.list,
                            color: Colors.black,
                          ),
                          trailing: const Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text(
                            "List item $index",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MemberDetail {
  String teamName = '';
  List<member> members = [];
}
