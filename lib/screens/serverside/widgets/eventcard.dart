import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/Event.dart';
import 'package:quiz_app/screens/AddEvent/AddMember.dart';

class EventCard extends StatelessWidget {
  final Color backgroundColor;
  late eventss restaurant;
  final VoidCallback onTap;

  EventCard({
    Key? key,
    required this.backgroundColor,
    required this.restaurant,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      color: backgroundColor.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        child: Container(
          height: 275,
          width: 220,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 300,
                  child: AspectRatio(
                    aspectRatio: 1.8,
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2018/01/12/10/19/fantasy-3077928_1280.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              //const Spacer(),
              const SizedBox(
                height: 10,
              ),
              FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: [
                    Text(
                      restaurant.type,
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      restaurant.dates,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        "Teams  ",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurant.Tteams.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              if (restaurant.status == 'created')
                ElevatedButton(
                    onPressed: () {
                      Get.to(AddMembersScreen(event: restaurant));
                    },
                    child: const Text('Add Teams'))
            ],
          ),
        ),
      ),
    );
  }
}

class CurrencyIcon extends StatelessWidget {
  final double size;
  final Color color;
  const CurrencyIcon({
    Key? key,
    required this.size,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$",
      style: GoogleFonts.montserrat(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: height,
        width: 1,
        color: Colors.grey.shade500,
      ),
    );
  }
}
