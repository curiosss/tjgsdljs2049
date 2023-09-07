import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hotel/core/network/dio_client.dart';

import 'core/local_storage/storage_hive.dart';
import 'core/network/connectivity_info.dart';

setupDependencies() async {
  try {
    StorageHive storageHive = StorageHive();
    await storageHive.init();
    Get.put(storageHive);

    Get.put(ConnectivityInfo());
    Get.put(NetworkService());
  } catch (e) {
    debugPrint(e.toString());
  }
}
