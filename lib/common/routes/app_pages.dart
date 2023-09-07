import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hotel/common/pages/error/not_found_page.dart';
import 'package:hotel/common/routes/routes.dart';
import 'package:hotel/features/hotel/presentation/pages/booking_page.dart';
import 'package:hotel/features/hotel/presentation/pages/hotel_page.dart';
import 'package:hotel/features/hotel/presentation/pages/order_accepted_page.dart';
import 'package:hotel/features/hotel/presentation/pages/rooms_page.dart';

Route<dynamic>? onGenerateAppRoute(RouteSettings? settings) {
  Widget? page;
  if (settings != null) {
    page = pages[settings.name];
  }

  return GetPageRoute(
    routeName: settings?.name,
    page: () => page ?? const NotFoundPage(),
    settings: settings,
  );
}

final Map pages = {
  Routes.hotel: const HotelPage(),
  Routes.room: const RoomsPage(),
  Routes.booking: const BookingPage(),
  Routes.orderAccepted: const OrderAcceptedPage(),
};
