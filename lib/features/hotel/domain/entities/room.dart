class Room {
  int id;
  String name;
  num price;
  String price_per;
  List<String> peculiarities;
  List<String> image_urls;
  Room({
    required this.id,
    required this.name,
    required this.price,
    required this.price_per,
    required this.peculiarities,
    required this.image_urls,
  });
}
