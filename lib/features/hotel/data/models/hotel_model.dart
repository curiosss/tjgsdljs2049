import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotel/features/hotel/domain/entities/hotel.dart';

class HotelModel extends Hotel {
  HotelModel({
    required super.id,
    required super.name,
    required super.address,
    required super.minimal_price,
    required super.price_for_it,
    required super.rating,
    required super.rating_name,
    required super.image_urls,
    required super.description,
    required super.peculiarities,
  });

  HotelModel copyWith({
    int? id,
    String? name,
    String? address,
    num? minimal_price,
    String? price_for_it,
    num? rating,
    String? rating_name,
    List<String>? image_urls,
    String? description,
    List<String>? peculiarities,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      minimal_price: minimal_price ?? this.minimal_price,
      price_for_it: price_for_it ?? this.price_for_it,
      rating: rating ?? this.rating,
      rating_name: rating_name ?? this.rating_name,
      image_urls: image_urls ?? this.image_urls,
      description: description ?? this.description,
      peculiarities: peculiarities ?? this.peculiarities,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'minimal_price': minimal_price});
    result.addAll({'price_for_it': price_for_it});
    result.addAll({'rating': rating});
    result.addAll({'rating_name': rating_name});
    result.addAll({'image_urls': image_urls});
    result.addAll({'description': description});
    result.addAll({'peculiarities': peculiarities});

    return result;
  }

  factory HotelModel.fromMap(Map<String, dynamic> map) {
    List<String> pecs = [];
    String desc = '';

    if (map['about_the_hotel'] != null) {
      desc = map['about_the_hotel']['description'] ?? '';
      pecs = List<String>.from(map['about_the_hotel']['peculiarities']);
    }
    return HotelModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      address: map['adress'] ?? '',
      minimal_price: map['minimal_price'] ?? 0,
      price_for_it: map['price_for_it'] ?? '',
      rating: map['rating'] ?? 0,
      rating_name: map['rating_name'] ?? '',
      image_urls: List<String>.from(map['image_urls']),
      description: desc,
      peculiarities: pecs,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelModel.fromJson(String source) =>
      HotelModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Hotel(id: $id, name: $name, address: $address, minimal_price: $minimal_price, price_for_it: $price_for_it, rating: $rating, rating_name: $rating_name, image_urls: $image_urls, description: $description, peculiarities: $peculiarities)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hotel &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.minimal_price == minimal_price &&
        other.price_for_it == price_for_it &&
        other.rating == rating &&
        other.rating_name == rating_name &&
        listEquals(other.image_urls, image_urls) &&
        other.description == description &&
        listEquals(
          other.peculiarities,
          peculiarities,
        );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
        minimal_price.hashCode ^
        price_for_it.hashCode ^
        rating.hashCode ^
        rating_name.hashCode ^
        image_urls.hashCode ^
        description.hashCode ^
        peculiarities.hashCode;
  }
}
