import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewScreen extends StatelessWidget {
  final bool isMediumSelected;
  final int totalPrice;

  const ViewScreen({
    super.key,
    required this.isMediumSelected,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/pizza.jpg',
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(25, 25, 0, 0),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 34, 139, 34),
              size: 45,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(255, 170, 0, 0),
          width: 120,
          height: 120,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 34, 139, 34),
            border: Border.all(color: Colors.white, width: 2.5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(21, 34, 0, 0),
            child: Text(
              '$totalPrice',
              style: GoogleFonts.rasa(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
