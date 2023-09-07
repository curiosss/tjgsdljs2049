import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hotel/features/hotel/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.name,
    required super.price,
    required super.price_per,
    required super.peculiarities,
    required super.image_urls,
  });

  Room copyWith({
    int? id,
    String? name,
    num? price,
    String? price_per,
    List<String>? peculiarities,
    List<String>? image_urls,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      price_per: price_per ?? this.price_per,
      peculiarities: peculiarities ?? this.peculiarities,
      image_urls: image_urls ?? this.image_urls,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'price': price});
    result.addAll({'price_per': price_per});
    result.addAll({'peculiarities': peculiarities});
    result.addAll({'image_urls': image_urls});

    return result;
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price'] ?? 0,
      price_per: map['price_per'] ?? '',
      peculiarities: List<String>.from(map['peculiarities']),
      image_urls: List<String>.from(map['image_urls']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Room(id: $id, name: $name, price: $price, price_per: $price_per, peculiarities: $peculiarities, image_urls: $image_urls)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Room &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.price_per == price_per &&
        listEquals(other.peculiarities, peculiarities) &&
        listEquals(other.image_urls, image_urls);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        price_per.hashCode ^
        peculiarities.hashCode ^
        image_urls.hashCode;
  }
}
