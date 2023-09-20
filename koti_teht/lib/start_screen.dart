import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startMc, this.startBk, this.startHs, {super.key});

  final void Function() startMc;
  final void Function() startHs;
  final void Function() startBk;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Missä haluat syödä?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: startMc,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 153, 0),
                ),
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text('MC Donald\'s'),
              ),
              OutlinedButton.icon(
                onPressed: startHs,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 230, 0),
                ),
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text('Hese'),
              ),
              OutlinedButton.icon(
                onPressed: startBk,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 172, 11, 11),
                ),
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text('Burgerking'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
