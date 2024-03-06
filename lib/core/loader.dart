import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lostnfound/components/loading_widget.dart';

class Loader {
  static success({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(20),
        icon: const Icon(CupertinoIcons.checkmark_circle_fill));
  }

  static warning({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          CupertinoIcons.exclamationmark_triangle,
        ));
  }

  static error({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(CupertinoIcons.exclamationmark_circle));
  }

  static void openLoading() {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: Color.fromARGB(132, 115, 113, 113),
              width: double.infinity,
              height: double.infinity,
              child: Column(children: [
                const SizedBox(
                  height: 250,
                ),
                AnimationLoader()
              ]),
            )));
  }

  static void closeLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
