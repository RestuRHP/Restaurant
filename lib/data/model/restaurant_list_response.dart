/// To parse this JSON data, do
///
///     final restaurantListResponse = restaurantListResponseFromJson(jsonString);
import 'dart:convert';

RestaurantListResponse restaurantListResponseFromJson(String str) =>
    RestaurantListResponse.fromJson(json.decode(str));

String restaurantListResponseToJson(RestaurantListResponse data) => json.encode(data.toJson());

class RestaurantListResponse {
  RestaurantListResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) => RestaurantListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        count: json["count"] == null ? null : json["count"],
        restaurants: json["restaurants"] == null
            ? null
            : List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "count": count == null ? null : count,
        "restaurants":
            restaurants == null ? null : List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        pictureId: json["pictureId"] == null ? null : json["pictureId"],
        city: json["city"] == null ? null : json["city"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "pictureId": pictureId == null ? null : pictureId,
        "city": city == null ? null : city,
        "rating": rating == null ? null : rating,
      };
}
