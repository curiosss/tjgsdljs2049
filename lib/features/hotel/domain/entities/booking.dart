class Booking {
  int id;
  String hotel_name;
  String hotel_adress;
  num horating;
  String rating_name;
  String departure;
  String arrival_country;
  String tour_date_start;
  String tour_date_stop;
  num number_of_nights;
  String room;
  String nutrition;
  num tour_price;
  num fuel_charge;
  num service_charge;
  num total_charge;
  Booking({
    required this.id,
    required this.hotel_name,
    required this.hotel_adress,
    required this.horating,
    required this.rating_name,
    required this.departure,
    required this.arrival_country,
    required this.tour_date_start,
    required this.tour_date_stop,
    required this.number_of_nights,
    required this.room,
    required this.nutrition,
    required this.tour_price,
    required this.fuel_charge,
    required this.service_charge,
    this.total_charge = 0,
  });
}
