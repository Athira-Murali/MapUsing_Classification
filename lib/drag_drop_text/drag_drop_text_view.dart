import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/constants/dimension.dart';
import 'data/data.dart';
import 'drag_drop_controller.dart';
import 'widgets/climate_draggable.dart';
import 'widgets/tick_button.dart';

class TextDragandDrop extends StatelessWidget {
  const TextDragandDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<DragDropController>(
        init: DragDropController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  fit: BoxFit.fitWidth,
                  height: height,
                  width: width,
                  alignment: Alignment.center,
                ),
                SafeArea(
                  //left: false,
                  right: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MatchTextView(),
                        const SizedBox(
                          width: 10,
                        ),
                        // _sideMenu()

                        Align(
                            alignment: Alignment.bottomRight,
                            child: TickButton(onPress: () {
                              controller.onTappedTick();
                            }))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MatchTextView extends StatelessWidget {
  MatchTextView({Key? key}) : super(key: key);

  final DragDropController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Center(
            child: MediaQuery(
                data: const MediaQueryData(textScaleFactor: 1),
                child: Text(
                  "Classification",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.black),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Summer",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    buildTarget(context,
                        climates: _controller.summer,
                        acceptTypes: [ClimateType.summer],
                        onAccept: (data) => _controller.onAcceptSummer(data)),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "Winter",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    buildTarget(context,
                        climates: _controller.winter,
                        acceptTypes: [ClimateType.winter],
                        onAccept: (data) => _controller.onAcceptWinter(data)),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  flex: 3,
                  child: LayoutBuilder(builder: (context, constraints) {
                    var spacing = 8.0;
                    var idealItemHeight = defaultItemHeight;

                    double totalHMargin = 16;
                    double totalVMargin = 16;
                    double padding = 4;
                    double width =
                        constraints.maxWidth - (2 * spacing) - (2 * padding);

                    final height = constraints.maxHeight -
                        2 * padding; //16 is sum of top and bottop padding
                    final totalRows = _controller.all.length;
                    final totalExpectedHeight = ((totalRows - 1) * spacing) +
                        (totalRows * idealItemHeight);

                    if (totalExpectedHeight > height) {
                      final extraHeight = totalExpectedHeight - height;

                      if (extraHeight <= (spacing - 5) * (totalRows - 1)) {
                        spacing = spacing - (extraHeight / (totalRows - 1));
                      } else {
                        double newSpacing = 5;
                        final reducedHeight = (spacing - 5) * (totalRows - 1);
                        final newExtraHeight = extraHeight - reducedHeight;
                        final singleRowSubHeight = newExtraHeight / totalRows;

                        spacing = newSpacing;
                        idealItemHeight = idealItemHeight - singleRowSubHeight;
                      }
                    }
                    return Center(
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 1,
                                      childAspectRatio:
                                          GetPlatform.isDesktop ? 3.20 : 1.9),
                              itemCount: _controller.all.length,
                              itemBuilder: (context, index) {
                                return ClimateDraggableWidgets(
                                  climate: _controller.all[index],
                                );
                              })),
                    );
                  }))
            ],
          ))
        ],
      ),
    ));
  }

  Widget buildTarget(
    BuildContext context, {
    required List<Climate> climates,
    required List<ClimateType> acceptTypes,
    required DragTargetAccept<Climate> onAccept,
  }) {
    final DragDropController controller = Get.find();

    return Expanded(
      flex: 4,
      child: LayoutBuilder(builder: (context, constraints) {
        var spacing = 8.0;
        var idealItemHeight = defaultItemHeight;

        double totalHMargin = 16;
        double totalVMargin = 16;
        double padding = 4;
        double width = constraints.maxWidth - (2 * spacing) - (2 * padding);

        final height = constraints.maxHeight -
            2 * padding; //8 is sum of top and bottop padding
        final totalRows = _controller.all.length;
        final totalExpectedHeight =
            ((totalRows - 1) * spacing) + (totalRows * idealItemHeight);

        if (totalExpectedHeight > height) {
          final extraHeight = totalExpectedHeight - height;

          if (extraHeight <= (spacing - 5) * (totalRows - 1)) {
            spacing = spacing - (extraHeight / (totalRows - 1));
          } else {
            double newSpacing = 5;
            final reducedHeight = (spacing - 5) * (totalRows - 1);
            final newExtraHeight = extraHeight - reducedHeight;
            final singleRowSubHeight = newExtraHeight / totalRows;

            spacing = newSpacing;
            idealItemHeight = idealItemHeight - singleRowSubHeight;
          }
        }

        return Container(
          color: Colors.blue.shade100.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: DragTarget<Climate>(
              builder: (context, candidateData, rejectedData) => GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: acceptTypes == ClimateType.values ? 3 : 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 1,
                      childAspectRatio: GetPlatform.isDesktop ? 3.20 : 1.2),
                  children: [
                    ...climates
                        .map(
                          (climate) => Draggable<Climate>(
                              data: climate,
                              feedback: buildDraggable(context, climate),
                              childWhenDragging: Container(height: 20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: (acceptTypes.contains(climate.type)
                                          ? Colors.green
                                          : Colors.red)
                                      // Colors.blue.shade200,
                                      ),
                                  child: Center(
                                      child: Text(
                                    climate.name!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                              )),
                        )
                        .toList()
                  ]),
              onWillAccept: (data) => true,
              onAccept: (data) {
                if (acceptTypes.contains(data.type)) {
                  debugPrint("correct");
                } else {
                  debugPrint("wrong");
                }
                onAccept(data);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget buildDraggable(BuildContext context, Climate climate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue,
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
