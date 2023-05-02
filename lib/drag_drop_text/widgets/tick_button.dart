import 'package:flutter/material.dart';

class TickButton extends StatelessWidget {
  const TickButton({Key? key, required this.onPress}) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPress,
        child: Image.asset(
          "assets/icons/done.png",
          height: 45,
          width: 45,
        ));
  }
}
