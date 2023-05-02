import 'package:flutter/material.dart';

import '../data/data.dart';

class ClimateDraggableWidgets extends StatelessWidget {
  final Climate climate;

  const ClimateDraggableWidgets({
    Key? key,
    required this.climate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Draggable<Climate>(
        data: climate,
        feedback: buildText(context),
        childWhenDragging: Container(height: 20),
        child: buildText(context),
      ),
    );
  }

  Widget buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        // height: 50,
        // width: 250,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
        ),
        child: Center(
            child: Text(
          climate.name!,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
