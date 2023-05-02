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
  //final allValues1 = [];
  Set<String> mainTypes = Set<String>();
  late List<String> list1 = List<String>.empty(growable: true);

  // final List<Climate> all = [];
  // final List<Climate> summer = [];
  // final List<Climate> winter = [];

  //final List<Climate> climates = [];

  //late final Climate climate;
  //bool ifseleced = false;

  // final _isSelected = false.obs;
  // bool get isSelected => _isSelected.value;

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
    // print(list1[0]);
    // print(list1[1]);

    print("fruitItems  $fruitItems");
    // print(vegetableItems);

    if (allValues1.isNotEmpty) {
      showErrorSnackbar(title: "Error", message: '--Incomplete--');
      print("incomplete");
      return;
    }
    for (int i = 0; i < fruitItems.length; i++) {
      if (fruitItems[i].type == list1[0]) {
        print("ssssssssss");
      } else {
        print("error");
      }

      for (int j = 0; j < vegetableItems.length; j++) {
        if (vegetableItems[i].type == list1[1]) {
          print("sssssss veg");
        }
        if (fruitItems[i].type == list1[0] &&
            vegetableItems[j].type == list1[1]) {
          showSuccessSnackbar(title: "", message: 'Success');
          //print("success");
        } else {
          showErrorSnackbar(title: "Error", message: '--failure--');
          //print("failure");
        }
      }
    }

    // for (int i = 0; i < fruitItems.length; i++) {
    //   if (fruitItems[i].type == list1[0]) {
    //     showSuccessSnackbar(title: "", message: 'Success');
    //     print("----SUCCESS---");
    //   } else {
    //     showErrorSnackbar(title: "Error", message: '--failure--');
    //     print('----FAILURE-----');
    //   }
    // }

    // final allFruitList =
    //     allValues1.where((element) => element.type == list1[0]);
    // final allVegetableList =
    //     allValues1.where((element) => element.type == list1[1]);
    // print("expected fruit list $allFruitList");

    // //print("expected veg list $allVegetableList");

    // final acceptedFruitList =
    //     fruitItems.where((element) => element.type == list1[0]);
    // final acceptedVegList =
    //     vegetableItems.where((element) => element.type == list1[1]);

    // print("acceptedFruitList  $acceptedFruitList");
    // print("acceptedVegList $acceptedVegList");

    // if (allFruitList.length == acceptedSList.length &&
    //     allVegetableList.length == acceptedWList.length) {
    //   print(" --SUCCESS---");
    //   showSuccessSnackbar(title: "", message: 'Success');
    // } else if (allValues1.isNotEmpty) {
    //   print("Incomplete");
    //   showErrorSnackbar(title: "Error", message: '--Incomplete--');
    // } else {
    //   print(" --FAILURE---");
    //   showErrorSnackbar(title: "Error", message: '--failure--');
    // }
    return;
  }

  // onTappedTick() {
  //   final allSList =
  //       allClimate.where((element) => element.type == ClimateType.summer);
  //   final allWList =
  //       allClimate.where((element) => element.type == ClimateType.winter);

  //   final acceptedSList =
  //       summer.where((element) => element.type == ClimateType.summer);
  //   final acceptedWList =
  //       winter.where((element) => element.type == ClimateType.winter);

  //   if (allSList.length == acceptedSList.length &&
  //       allWList.length == acceptedWList.length) {
  //     print(" --SUCCESS---");
  //     showSuccessSnackbar(title: "", message: 'Success');
  //   } else if (all.isNotEmpty) {
  //     print("Incomplete");
  //     showErrorSnackbar(title: "Error", message: '--Incomplete--');
  //   } else {
  //     print(" --FAILURE---");
  //     showErrorSnackbar(title: "Error", message: '--failure--');
  //   }
  //   return;
  // }
}
