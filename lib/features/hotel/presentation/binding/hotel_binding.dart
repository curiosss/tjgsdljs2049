import 'package:get/get.dart';
import 'package:hotel/features/hotel/presentation/controller/hotel_controller.dart';

class HotelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HotelController());
  }
}
