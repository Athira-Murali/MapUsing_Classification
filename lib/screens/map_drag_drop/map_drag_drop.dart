import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../drag_drop_text/widgets/tick_button.dart';
import '../../utils/constants/dimension.dart';
import '../model/basketmodel.dart';
import '../widgets/map_draggable.dart';

class MapDragDropTextDragandDrop extends StatelessWidget {
  const MapDragDropTextDragandDrop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                  // Align(
                  //     alignment: Alignment.bottomRight,
                  //     child: TickButton(onPress: () {
                  //       onTappedTick();
                  //     }))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchTextView extends StatefulWidget {
  const MatchTextView({Key? key}) : super(key: key);

  @override
  State<MatchTextView> createState() => _MatchTextViewState();
}

class _MatchTextViewState extends State<MatchTextView> {
  @override
  initState() {
    setValues();
//all.addAll(allClimate);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  setValues() {
    allValues = basket.values.expand((list) => list).toList();

    print("----allValues---- $allValues");

    // for (int i = 0; i < basket.length; i++);
    basket.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        allValues1.add(Basket(type: key, name: value[i]));
      }
    });
    print("basket model");
    print(allValues1.toList());

    for (int i = 0; i < allValues1.length; i++) {
      mainTypes.add(allValues1[i].toString().split(":")[0]);

      //print(allValues1[i].toString().split(":")[0]);
    }
    list1 = mainTypes.toList();
    print("****mainTypes***  $mainTypes");
    print("list1 ---- $list1");
  }

  Map<String, List<String>> basket = {
    'fruit': [
      'apple',
      'banana',
      'orange',
    ],
    'vegetable': [
      'carrot',
      'broccoli',
      'tomato',
    ]
  };

  List<String> allValues = [];
  List<Basket> fruitItems = [];
  List<Basket> vegetableItems = [];
  final List<Basket> allValues1 = [];
  //final allValues1 = [];
  Set<String> mainTypes = Set<String>();
  late List<String> list1 = List<String>.empty(growable: true);

  void removeAll(Basket toRemove) {
    allValues1.removeWhere((allItem) => allItem.name == toRemove.name);
    fruitItems.removeWhere((allItem) => allItem.name == toRemove.name);
    vegetableItems.removeWhere((allItem) => allItem.name == toRemove.name);
  }

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
                        basket1: fruitItems,
                        acceptTypes: [list1[0].toString()],
                        onAccept: (data) => setState(() {
                              removeAll(data);
                              fruitItems.add(data);
                            })),
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
                        basket1: vegetableItems,
                        acceptTypes: [list1[1].toString()],
                        onAccept: (data) => setState(() {
                              removeAll(data);
                              vegetableItems.add(data);
                            })),
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
                      final totalRows = allValues1.length;
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
                                        childAspectRatio: 2.4
                                        // childAspectRatio:
                                        //     GetPlatform.isDesktop ? 3.20 : 2.0

                                        ),
                                itemCount: allValues1.length,
                                itemBuilder: (context, index) {
                                  return BasketDraggableWidgets(
                                    basket: allValues1[index],
                                  );
                                })),
                      );
                    }),
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TickButton(onPress: () {
                    onTappedTick();
                  }))
            ],
          ))
        ],
      ),
    ));
  }

  onTappedTick() {
    final allFruitList =
        fruitItems.where((element) => element.type == list1[0]);
    final allVegList =
        vegetableItems.where((element) => element.type == list1[1]);

    print("Expected fruit list: ${basket['fruit']}");
    print("Expected veg list: ${basket['vegetable']}");

    final acceptedFruitList =
        fruitItems.where((element) => basket['fruit']!.contains(element.name));
    final acceptedVegList = vegetableItems
        .where((element) => basket['vegetable']!.contains(element.name));

    print("Accepted fruit list: $acceptedFruitList");
    print("Accepted veg list: $acceptedVegList");

    if (allValues1.isNotEmpty) {
      print("Incomplete");

      return;
    } else if (acceptedFruitList.length == allFruitList.length &&
        acceptedVegList.length == allVegList.length) {
      print(" --SUCCESS--");
    } else {
      print(" --FAILURE---");
    }
  }

  onTappedTick1() {
    // final fruitBasket = basket['fruit'];
    // final vegBasket = basket['vegetable'];

    final allFruitList =
        fruitItems.where((element) => element.type == list1[0]);
    final allVegList =
        vegetableItems.where((element) => element.type == list1[1]);

    print("expected fruit list $allFruitList");

    print("expected veg list $allVegList");

    final acceptedFruitList =
        fruitItems.where((element) => element.type == list1[0]);
    final acceptedVegList =
        vegetableItems.where((element) => element.type == list1[1]);

    print("acceptedFruitList  $acceptedFruitList");
    print("acceptedVegList $acceptedVegList");

    if (allValues1.isNotEmpty) {
      print("Incomplete");
      return;
    } else if (allFruitList.length == acceptedFruitList.length &&
        allVegList.length == acceptedVegList.length) {
      print(" --SUCCESS---");
    } else {
      print(" --FAILURE---");
    }
    return;
  }

  Widget buildTarget(
    BuildContext context, {
    required List<Basket> basket1,
    required List<String> acceptTypes,
    required DragTargetAccept<Basket> onAccept,
  }) {
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
        final totalRows = allValues.length;
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
