import 'package:flutter/material.dart';

const kSecondaryColor = Color(0xFF8B94BC);
const careem = Color.fromARGB(255, 246, 246, 241);
const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color.fromARGB(255, 154, 182, 248);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 244, 36, 36),
    Color.fromARGB(255, 105, 255, 138),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

const double kDefaultPadding = 20.0;
getTextInputField(controller, hint) {
  return Container(
    alignment: Alignment.center,
    height: 100,
    child: TextField(
      controller: controller.value,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 240, 227, 202),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 23),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    ),
  );
  // const Spacer(), // 1/6
}

getTextInputField1(controller, hint) {
  return Container(
    alignment: Alignment.center,
    height: 70,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 240, 227, 202),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        //focusColor: Colors.black,
        //focusedBorder: const OutlineInputBorder(),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
  // const Spacer(), // 1/6
}
