/// To parse this JSON data, do
///
///     final detailRestaurantResponse = detailRestaurantResponseFromJson(jsonString);

import 'dart:convert';

DetailRestaurantResponse detailRestaurantResponseFromJson(String str) => DetailRestaurantResponse.fromJson(json.decode(str));

String detailRestaurantResponseToJson(DetailRestaurantResponse data) => json.encode(data.toJson());

class DetailRestaurantResponse {
  DetailRestaurantResponse({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) => DetailRestaurantResponse(
    error: json["error"] == null ? null : json["error"],
    message: json["message"] == null ? null : json["message"],
    restaurant: json["restaurant"] == null ? null : Restaurant.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? null : error,
    "message": message == null ? null : message,
    "restaurant": restaurant == null ? null : restaurant.toJson(),
  };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.menus,
    this.categories,
    this.rating,
    this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  Menus menus;
  List<Category> categories;
  double rating;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    city: json["city"] == null ? null : json["city"],
    address: json["address"] == null ? null : json["address"],
    pictureId: json["pictureId"] == null ? null : json["pictureId"],
    menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    customerReviews: json["customerReviews"] == null ? null : List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "city": city == null ? null : city,
    "address": address == null ? null : address,
    "pictureId": pictureId == null ? null : pictureId,
    "menus": menus == null ? null : menus.toJson(),
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
    "rating": rating == null ? null : rating,
    "customerReviews": customerReviews == null ? null : List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
  };
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"] == null ? null : json["name"],
    review: json["review"] == null ? null : json["review"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "review": review == null ? null : review,
    "date": date == null ? null : date,
  };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: json["foods"] == null ? null : List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
    drinks: json["drinks"] == null ? null : List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "foods": foods == null ? null : List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": drinks == null ? null : List<dynamic>.from(drinks.map((x) => x.toJson())),
  };
}
