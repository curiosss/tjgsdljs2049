import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel/core/errors/errors.dart';
import 'package:hotel/core/network/connectivity_info.dart';
import 'package:hotel/core/network/dio_client.dart';
import 'package:hotel/features/hotel/data/models/booking_model.dart';
import 'package:hotel/features/hotel/data/models/hotel_model.dart';
import 'package:hotel/features/hotel/data/models/room_model.dart';
import 'package:hotel/features/hotel/domain/repositories/hotel_repository.dart';

class HotelRepoImpl implements HotelRepository {
  ConnectivityInfo connectivityInfo = Get.find<ConnectivityInfo>();
  NetworkService networkService = Get.find<NetworkService>();

  @override
  Future<(HotelModel?, KError?)> getHotel() async {
    try {
      if (!await connectivityInfo.isConnected()) {
        return (null, NoInternet());
      }

      var res = await networkService.httpClient
          .get('/35e0d18e-2521-4f1b-a575-f0fe366f66e3');
      if (res.statusCode == 200) {
        HotelModel? hotel = HotelModel.fromMap(res.data);
        return (hotel, null);
      }
      return (null, null);
    } catch (e) {
      debugPrint(e.toString());
      return (null, ServerError(err: e));
    }
  }

  @override
  Future<(List<RoomModel>?, KError?)> getRooms() async {
    try {
      if (!await connectivityInfo.isConnected()) {
        return (null, NoInternet());
      }

      var res = await networkService.httpClient
          .get('/f9a38183-6f95-43aa-853a-9c83cbb05ecd');
      if (res.statusCode == 200 && res.data['rooms'] != null) {
        List<RoomModel> rooms = List<RoomModel>.from(res.data['rooms'].map((e) {
          return RoomModel.fromMap(e);
        }));
        return (rooms, null);
      }
      return (null, null);
    } catch (e) {
      debugPrint(e.toString());
      return (null, ServerError(err: e));
    }
  }

  @override
  Future<(BookingModel?, KError?)> getBooking() async {
    try {
      if (!await connectivityInfo.isConnected()) {
        return (null, NoInternet());
      }

      var res = await networkService.httpClient
          .get('/e8868481-743f-4eb2-a0d7-2bc4012275c8');
      if (res.statusCode == 200 && res.data != null) {
        BookingModel booking = BookingModel.fromMap(res.data);
        return (booking, null);
      }
      return (null, null);
    } catch (e) {
      debugPrint(e.toString());
      return (null, ServerError(err: e));
    }
  }
}
