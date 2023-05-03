import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../mixins/snackbar_mixin.dart';
import '../model/basketmodel.dart';

class ClassificationController extends GetxController with SnackbarMixin {
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

  Set<String> mainTypes = Set<String>();
  late List<String> list1 = List<String>.empty(growable: true);

  @override
  void onInit() {
    setValues();
    super.onInit();

    //all.addAll(allClimate);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void removeAll(Basket toRemove) {
    allValues1.removeWhere((allItem) => allItem.name == toRemove.name);
    fruitItems.removeWhere((allItem) => allItem.name == toRemove.name);
    vegetableItems.removeWhere((allItem) => allItem.name == toRemove.name);
  }

  setValues() {
    //allValues = basket.values.expand((list) => list).toList();

    basket.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        allValues1.add(Basket(type: key, name: value[i]));
      }
    });
    print("basket model");
    allValues1.toList().shuffle(Random());
    print(allValues..toList().shuffle());
    // print(allValues1.toList());
    for (int i = 0; i < allValues1.length; i++) {
      mainTypes.add(allValues1[i].toString().split(":")[0]);

      //print(allValues1[i].toString().split(":")[0]);
    }
    list1 = mainTypes.toList();
    print("****mainTypes***  $mainTypes");
    print("list1 ---- $list1");
  }

  onAcceptFruit(data) {
    removeAll(data);
    fruitItems.add(data);
    update();
  }

  onAcceptVegetable(data) {
    removeAll(data);
    vegetableItems.add(data);
    update();
  }

  onTappedTick() {
    final allFruitList =
        fruitItems.where((element) => element.type == list1[0]);
    final allVegList =
        vegetableItems.where((element) => element.type == list1[1]);

    print("allFruitList: $allFruitList");
    //print("Expected veg list: ${basket['vegetable']}");

    // final acceptedFruitList =
    //     fruitItems.where((element) => basket['fruit']!.contains(element.name));
    // final acceptedVegList = vegetableItems
    //     .where((element) => basket['vegetable']!.contains(element.name));

    // print("Accepted fruit list: $acceptedFruitList");
    //print("Accepted veg list: $acceptedVegList");

    if (allValues1.isNotEmpty) {
      print("Incomplete");
      showErrorSnackbar(title: "Error", message: '--Incomplete--');
      return;
    }
    if (allFruitList.length == fruitItems.length &&
        allVegList.length == vegetableItems.length) {
      print(" --SUCCESS---");
      showSuccessSnackbar(title: "", message: 'Success');
    } else {
      print(" --FAILURE---");
      showErrorSnackbar(title: "Error", message: '--failure--');
    }
  }
}
