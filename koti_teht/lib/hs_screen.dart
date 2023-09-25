import 'package:flutter/material.dart';

class HsScreen extends StatefulWidget {
  const HsScreen(this.startMc, this.startBk, this.startHs, {super.key});

  final void Function() startMc;
  final void Function() startHs;
  final void Function() startBk;

  @override
  State<HsScreen> createState() {
    return _HsScreenState();
  }
}

class _HsScreenState extends State<HsScreen> {
  final _activeButton = "active";

  @override
  Widget build(BuildContext context) {
    Color activeColor = Colors.black;
    Color defaultColor = Colors.white;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Hesburger',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 230, 0),
            ),
          ),
          Image.asset(
            'assets/images/hese.jpg',
            width: 200,
            height: 180,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                onPressed: widget.startMc,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 153, 0),
                ),
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text('Mäkki'),
              ),
              OutlinedButton.icon(
                onPressed: widget.startHs,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 230, 0),
                  backgroundColor:
                      _activeButton == "active" ? activeColor : defaultColor,
                ),
                icon: const Icon(Icons.food_bank_outlined),
                label: const Text('Hese'),
              ),
              OutlinedButton.icon(
                onPressed: widget.startBk,
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
