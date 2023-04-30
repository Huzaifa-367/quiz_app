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
      appBar: AppBar(
        title: Text(widget.event.type),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Team Details'),
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
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'select no of members',
              ),
              value: noOfteams,
              onChanged: (newValue) {
                setState(() {
                  noOfteams = newValue;
                });
              },
              items: noteams.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Member' s Detail"),
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
            ElevatedButton(onPressed: () {}, child: const Text('Add'))
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
