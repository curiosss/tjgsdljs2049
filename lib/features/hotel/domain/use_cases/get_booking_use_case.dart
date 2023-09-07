import 'package:hotel/core/errors/errors.dart';
import 'package:hotel/features/hotel/domain/entities/booking.dart';
import 'package:hotel/features/hotel/domain/repositories/hotel_repository.dart';

class GetBookingUseCase {
  final HotelRepository hotelRepository;

  GetBookingUseCase({required this.hotelRepository});

  Future<(Booking?, KError?)> getBooking() async {
    var data = await hotelRepository.getBooking();
    if (data.$1 != null) {
      Booking booking = data.$1!;
      booking.total_charge =
          booking.fuel_charge + booking.service_charge + booking.tour_price;
      return (booking, data.$2);
    }
    return data;
  }
}
