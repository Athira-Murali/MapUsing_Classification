import 'package:flutter/material.dart';

import 'data/data.dart';

class ClassifyDragDrop extends StatefulWidget {
  const ClassifyDragDrop({Key? key}) : super(key: key);

  @override
  State<ClassifyDragDrop> createState() => _ClassifyDragDropState();
}

class _ClassifyDragDropState extends State<ClassifyDragDrop> {
  final List<Climate> climates = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
              child: Container(
            height: 200,
            width: 200,
            color: Colors.pink.shade100,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 1,
                  childAspectRatio: 2.1),
              children: [
                ...climates
                    .map((climate) => ClimateDraggableWidget(climate: climate))
              ],
            ),
          ))
        ],
      )),
    );
  }
}

class ClimateDraggableWidget extends StatelessWidget {
  final Climate climate;

  const ClimateDraggableWidget({
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
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade200,
        ),
        child: Center(
            child: Text(climate.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black))),
      ),
    );
  }
}
