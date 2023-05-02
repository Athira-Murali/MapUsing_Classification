import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../mixins/snackbar_mixin.dart';
import 'data/data.dart';

class DragDropController extends GetxController with SnackbarMixin {
  final List<Climate> all = [];
  final List<Climate> summer = [];
  final List<Climate> winter = [];

  @override
  void onInit() {
    super.onInit();

    all.addAll(allClimate);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void removeAll(Climate toRemove) {
    all.removeWhere((climate) => climate.name == toRemove.name);
    summer.removeWhere((climate) => climate.name == toRemove.name);
    winter.removeWhere((climate) => climate.name == toRemove.name);
  }

  onAcceptSummer(data) {
    removeAll(data);
    summer.add(data);
    update();
  }

  onAcceptWinter(data) {
    removeAll(data);
    winter.add(data);
    update();
  }

  onTappedTick() {
    final allSList =
        allClimate.where((element) => element.type == ClimateType.summer);
    final allWList =
        allClimate.where((element) => element.type == ClimateType.winter);
    print(allSList);
    print(allWList);

    final acceptedSList =
        summer.where((element) => element.type == ClimateType.summer);
    final acceptedWList =
        winter.where((element) => element.type == ClimateType.winter);
    print(acceptedSList);

    if (allSList.length == acceptedSList.length &&
        allWList.length == acceptedWList.length) {
      print(" --SUCCESS---");
      showSuccessSnackbar(title: "", message: 'Success');
    } else if (all.isNotEmpty) {
      print("Incomplete");
      showErrorSnackbar(title: "Error", message: '--Incomplete--');
    } else {
      print(" --FAILURE---");
      showErrorSnackbar(title: "Error", message: '--failure--');
    }
    return;
  }
}
