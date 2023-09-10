import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String title;
   Color color;
   VoidCallback onPress;

  Button({
    Key? key,
    required this.title,
    this.color = const Color(0xffefefef),
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: InkWell(
          onTap: onPress, // Pass a callback function
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}