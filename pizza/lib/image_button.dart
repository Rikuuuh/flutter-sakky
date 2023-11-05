import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  const ImageButton({super.key});
  @override
  ImageButtonState createState() => ImageButtonState();
}

class ImageButtonState extends State<ImageButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(2, 1, 3, 1),
            width: 110,
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
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          if (isSelected)
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
    );
  }
}
