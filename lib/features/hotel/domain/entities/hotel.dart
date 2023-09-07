class Hotel {
  int id;
  String name;
  String address;
  num minimal_price;
  String price_for_it;
  num rating;
  String rating_name;
  List<String> image_urls;
  String description;
  List<String> peculiarities;
  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.minimal_price,
    required this.price_for_it,
    required this.rating,
    required this.rating_name,
    required this.image_urls,
    required this.description,
    required this.peculiarities,
  });
}
