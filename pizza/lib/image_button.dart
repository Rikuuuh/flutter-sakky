import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  const ImageButton({super.key});
  @override
  ImageButtonState createState() => ImageButtonState();
}

class ImageButtonState extends State<ImageButton> {
  List<bool> isSelected = [false, false, false];
  void toggleSelection(int index) {
    setState(() {
      // Kääntää ainoastaan kyseisen napin tilan
      isSelected[index] = !isSelected[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              toggleSelection(0); // Ensimmäinen nappi
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(2, 1, 3, 1),
                width: 90,
                height: 110,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/valkosipuli.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Positioned(
                  bottom: 10,
                  child: Column(
                    children: [
                      Text(
                        'valkosipuli',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              if (isSelected[0])
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              toggleSelection(1); // Toinen nappi
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(2, 1, 3, 1),
                width: 90,
                height: 110,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/tomaatti.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Positioned(
                  bottom: 10,
                  child: Column(
                    children: [
                      Text(
                        'kirsikkatomaatti',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
              if (isSelected[1])
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              toggleSelection(2); // Kolmas nappi
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(2, 1, 3, 1),
                width: 90,
                height: 110,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/juusto.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const Positioned(
                bottom: 10,
                child: Column(
                  children: [
                    Text(
                      'aura@-juusto',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected[2])
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
