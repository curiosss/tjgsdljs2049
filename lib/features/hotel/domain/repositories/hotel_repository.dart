import 'package:hotel/core/errors/errors.dart';
import 'package:hotel/features/hotel/domain/entities/booking.dart';
import 'package:hotel/features/hotel/domain/entities/hotel.dart';
import 'package:hotel/features/hotel/domain/entities/room.dart';

abstract class HotelRepository {
  Future<(Hotel?, KError?)> getHotel();
  Future<(List<Room>?, KError?)> getRooms();
  Future<(Booking?, KError?)> getBooking();
}
