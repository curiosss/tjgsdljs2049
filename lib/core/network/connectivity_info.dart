import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityInfo {
  Connectivity connectivity = Connectivity();

  Future<bool> isConnected({showMessage = true}) async {
    final result = await connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      return true;
    }
    Get.showSnackbar(const GetSnackBar(
      title: 'Нет подключение к интернету!',
    ));
    return false;
  }
}
