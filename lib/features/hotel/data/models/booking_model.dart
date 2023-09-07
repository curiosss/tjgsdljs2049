import 'dart:convert';

import 'package:hotel/features/hotel/domain/entities/booking.dart';

class BookingModel extends Booking {
  BookingModel({
    required super.id,
    required super.hotel_name,
    required super.hotel_adress,
    required super.horating,
    required super.rating_name,
    required super.departure,
    required super.arrival_country,
    required super.tour_date_start,
    required super.tour_date_stop,
    required super.number_of_nights,
    required super.room,
    required super.nutrition,
    required super.tour_price,
    required super.fuel_charge,
    required super.service_charge,
  });

  Booking copyWith({
    int? id,
    String? hotel_name,
    String? hotel_adress,
    num? horating,
    String? rating_name,
    String? departure,
    String? arrival_country,
    String? tour_date_start,
    String? tour_date_stop,
    num? number_of_nights,
    String? room,
    String? nutrition,
    num? tour_price,
    num? fuel_charge,
    num? service_charge,
  }) {
    return Booking(
      id: id ?? this.id,
      hotel_name: hotel_name ?? this.hotel_name,
      hotel_adress: hotel_adress ?? this.hotel_adress,
      horating: horating ?? this.horating,
      rating_name: rating_name ?? this.rating_name,
      departure: departure ?? this.departure,
      arrival_country: arrival_country ?? this.arrival_country,
      tour_date_start: tour_date_start ?? this.tour_date_start,
      tour_date_stop: tour_date_stop ?? this.tour_date_stop,
      number_of_nights: number_of_nights ?? this.number_of_nights,
      room: room ?? this.room,
      nutrition: nutrition ?? this.nutrition,
      tour_price: tour_price ?? this.tour_price,
      fuel_charge: fuel_charge ?? this.fuel_charge,
      service_charge: service_charge ?? this.service_charge,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'hotel_name': hotel_name});
    result.addAll({'hotel_adress': hotel_adress});
    result.addAll({'horating': horating});
    result.addAll({'rating_name': rating_name});
    result.addAll({'departure': departure});
    result.addAll({'arrival_country': arrival_country});
    result.addAll({'tour_date_start': tour_date_start});
    result.addAll({'tour_date_stop': tour_date_stop});
    result.addAll({'number_of_nights': number_of_nights});
    result.addAll({'room': room});
    result.addAll({'nutrition': nutrition});
    result.addAll({'tour_price': tour_price});
    result.addAll({'fuel_charge': fuel_charge});
    result.addAll({'service_charge': service_charge});

    return result;
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id']?.toInt() ?? 0,
      hotel_name: map['hotel_name'] ?? '',
      hotel_adress: map['hotel_adress'] ?? '',
      horating: map['horating'] ?? 0,
      rating_name: map['rating_name'] ?? '',
      departure: map['departure'] ?? '',
      arrival_country: map['arrival_country'] ?? '',
      tour_date_start: map['tour_date_start'] ?? '',
      tour_date_stop: map['tour_date_stop'] ?? '',
      number_of_nights: map['number_of_nights'] ?? 0,
      room: map['room'] ?? '',
      nutrition: map['nutrition'] ?? '',
      tour_price: map['tour_price'] ?? 0,
      fuel_charge: map['fuel_charge'] ?? 0,
      service_charge: map['service_charge'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(id: $id, hotel_name: $hotel_name, hotel_adress: $hotel_adress, horating: $horating, rating_name: $rating_name, departure: $departure, arrival_country: $arrival_country, tour_date_start: $tour_date_start, tour_date_stop: $tour_date_stop, number_of_nights: $number_of_nights, room: $room, nutrition: $nutrition, tour_price: $tour_price, fuel_charge: $fuel_charge, service_charge: $service_charge)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.id == id &&
        other.hotel_name == hotel_name &&
        other.hotel_adress == hotel_adress &&
        other.horating == horating &&
        other.rating_name == rating_name &&
        other.departure == departure &&
        other.arrival_country == arrival_country &&
        other.tour_date_start == tour_date_start &&
        other.tour_date_stop == tour_date_stop &&
        other.number_of_nights == number_of_nights &&
        other.room == room &&
        other.nutrition == nutrition &&
        other.tour_price == tour_price &&
        other.fuel_charge == fuel_charge &&
        other.service_charge == service_charge;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hotel_name.hashCode ^
        hotel_adress.hashCode ^
        horating.hashCode ^
        rating_name.hashCode ^
        departure.hashCode ^
        arrival_country.hashCode ^
        tour_date_start.hashCode ^
        tour_date_stop.hashCode ^
        number_of_nights.hashCode ^
        room.hashCode ^
        nutrition.hashCode ^
        tour_price.hashCode ^
        fuel_charge.hashCode ^
        service_charge.hashCode;
  }
}
