import 'package:flutter/material.dart';

import '../model/basketmodel.dart';

// import '../data/data.dart';

class BasketDraggableWidgets extends StatelessWidget {
  final Basket basket;

  const BasketDraggableWidgets({
    Key? key,
    required this.basket,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Draggable<Basket>(
        data: basket,
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
          basket.name!,
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
