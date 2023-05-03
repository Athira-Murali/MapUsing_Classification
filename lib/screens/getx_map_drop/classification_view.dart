import 'package:classification/screens/getx_map_drop/classification_controller.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../drag_drop_text/widgets/tick_button.dart';
import '../../utils/constants/dimension.dart';
import '../model/basketmodel.dart';
import '../widgets/map_draggable.dart';

// import 'widgets/climate_draggable.dart';

class ClassificationTextDragandDrop extends StatelessWidget {
  const ClassificationTextDragandDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<ClassificationController>(
        init: ClassificationController(),
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

class MatchTextView extends StatefulWidget {
  const MatchTextView({Key? key}) : super(key: key);

  @override
  State<MatchTextView> createState() => _MatchTextViewState();
}

class _MatchTextViewState extends State<MatchTextView> {
  final ClassificationController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Center(
              child: Text(
            "Classification",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'fruit',
                      style: TextStyle(fontSize: 14),
                    ),
                    buildTarget(context,
                        basket1: _controller.fruitItems,
                        acceptTypes: [_controller.list1[0].toString()],
                        onAccept: (data) => _controller.onAcceptFruit(data)),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      'Vegetable',
                      style: TextStyle(fontSize: 14),
                    ),
                    buildTarget(context,
                        basket1: _controller.vegetableItems,
                        acceptTypes: [_controller.list1[1].toString()],
                        onAccept: (data) =>
                            _controller.onAcceptVegetable(data)),
                  ],
                ),
              ),

              //gridview builder

              Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.blue.shade100,
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
                      final totalRows = _controller.allValues1.length;
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
                          idealItemHeight =
                              idealItemHeight - singleRowSubHeight;
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
                                      GetPlatform.isDesktop ? 3.20 : 2.0,
                                  //childAspectRatio: 2.4
                                ),
                                itemCount: _controller.allValues1.length,
                                itemBuilder: (context, index) {
                                  return BasketDraggableWidgets(
                                    basket: _controller.allValues1[index],
                                  );
                                })),
                      );
                    }),
                  )),
            ],
          ))
        ],
      ),
    ));
  }

  Widget buildTarget(
    BuildContext context, {
    required List<Basket> basket1,
    required List<String> acceptTypes,
    required DragTargetAccept<Basket> onAccept,
  }) {
    final ClassificationController controller = Get.find();

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
        final totalRows = _controller.allValues.length;
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
            child: DragTarget<Basket>(
              builder: (context, candidateData, rejectedData) => GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 1,
                      childAspectRatio: GetPlatform.isDesktop ? 3.20 : 1.2),
                  children: [
                    ...basket1
                        .map(
                          (basket) => Draggable<Basket>(
                            data: basket,
                            feedback: buildDraggable(context, basket),
                            childWhenDragging: Container(height: 20),
                            child: buildDraggable(context, basket),
                          ),
                        )
                        .toList()
                  ]),
              onWillAccept: (data) => true,
              onAccept: (data) {
                if (acceptTypes.contains(data.type)) {
                  print("target drop data type");
                  print(data.type);
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

  Widget buildDraggable(BuildContext context, Basket basket) {
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
            child: Text(basket.name!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black))),
      ),
    );
  }
}
