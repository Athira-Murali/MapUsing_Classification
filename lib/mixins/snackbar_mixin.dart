import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';

mixin SnackbarMixin on GetxController {
  showErrorSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showSuccessSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showInfoSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      //blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showToastSnackbar({required String message}) {
    Flushbar(
      messageText: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF303030)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(message,
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showActivityInfoSnackBar({required String message}) {
    Flushbar(
      messageText: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    8,
                    8,
                    8,
                  ),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }
}
