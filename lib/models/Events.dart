class Restaurant {
  final String? id;
  final String imageUrl;
  final String name;
  final String resType;
  final String rating;
  final String price;
  final String distance;

  Restaurant({
    this.id,
    required this.imageUrl,
    required this.name,
    required this.resType,
    required this.rating,
    required this.price,
    required this.distance,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'].toString(),
      imageUrl: json['imageUrl'] ?? "",
      name: json['name'],
      resType: json['resType'],
      rating: json['rating'],
      price: json['price'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['resType'] = resType;
    data['rating'] = rating;
    data['price'] = price;
    data['distance'] = distance;
    return data;
  }
}

List<Restaurant> cachedRestaurantList = [
  Restaurant(
    id: "1",
    imageUrl: "assets/icons/testing.jpeg",
    name: "Molon Lave",
    resType: "Asian Kitchen",
    rating: "4.7",
    price: "30",
    distance: "0.2",
  ),
  Restaurant(
    id: "2",
    imageUrl: "assets/icons/testing.jpeg",
    name: "Bostan Barista",
    resType: "Pubs",
    rating: "4.8",
    price: "50",
    distance: "1.2",
  ),
  Restaurant(
    id: "3",
    imageUrl: "assets/icons/testing.jpeg",
    name: "Family Bean",
    resType: "Cafe",
    rating: "3.9",
    price: "45",
    distance: "3.1",
  ),
  Restaurant(
    id: "4",
    imageUrl: "assets/icons/testing.jpeg",
    name: "Power House",
    resType: "Vegan",
    rating: "4.2",
    price: "28",
    distance: "0.6",
  ),
  Restaurant(
    id: "5",
    imageUrl: "assets/icons/testing.jpeg",
    name: "Lureme",
    resType: "Cocktail Bar",
    rating: "4.3",
    price: "55",
    distance: "1.2",
  ),
];
