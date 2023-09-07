import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/common/routes/routes.dart';
import 'package:hotel/features/hotel/data/repositories/hotel_repo_impl.dart';
import 'package:hotel/features/hotel/domain/entities/booking.dart';
import 'package:hotel/features/hotel/domain/entities/hotel.dart';
import 'package:hotel/features/hotel/domain/entities/room.dart';
import 'package:hotel/features/hotel/domain/use_cases/get_booking_use_case.dart';

class HotelController {
  late HotelRepoImpl hotelRepoImpl;
  late GetBookingUseCase getBookingUseCase;

  HotelController() {
    hotelRepoImpl = HotelRepoImpl();
    getBookingUseCase = GetBookingUseCase(hotelRepository: hotelRepoImpl);
  }

  RxBool isloading = false.obs;
  RxBool isRoomsLoading = false.obs;
  RxBool isBookingsLoading = false.obs;

  Hotel? hotel;
  List<Room> rooms = [];
  Booking? booking;

  getHotel() async {
    isloading.value = true;
    var data = await hotelRepoImpl.getHotel();
    hotel = data.$1;
    isloading.value = false;
  }

  getRooms() async {
    isRoomsLoading.value = true;
    var data = await hotelRepoImpl.getRooms();
    if (data.$1 != null) {
      rooms = data.$1!;
    }
    isRoomsLoading.value = false;
  }

  getBookings() async {
    isBookingsLoading.value = true;
    var data = await getBookingUseCase.getBooking();
    booking = data.$1;
    isBookingsLoading.value = false;
  }

  proceedToPayment(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(seconds: 3));
    //TODO implement payment
    debugPrint(data.toString());
    //if success
    Get.offNamed(Routes.orderAccepted);
  }

  final Map<int, String> names = {
    1: 'Первый турист',
    2: 'Второй турист',
    3: 'Третий турист',
    4: 'Четвертый турист',
    5: 'Пятый турист',
    6: 'Шестой турист',
    7: 'Седьмой турист',
  };

  String getTitle(int order) {
    if (names[order] != null) {
      return names[order]!;
    }
    return 'Турист № $order';
  }
}
