import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetWorkManager extends GetxController {
  static NetWorkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectiviySubcription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectiviySubcription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityStatus);
  }

  // Update connection status
  Future<void> _updateConnectivityStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      // Loader.warning(title: 'No Internet Connection');
    }
  }

  // Check connection status
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // Close/Dispose the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    _connectiviySubcription.cancel();
  }
}
