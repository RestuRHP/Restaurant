import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:submission_fudamental_flutter/data/model/detail_restaurant_response.dart';
import 'package:submission_fudamental_flutter/service/service.dart';

class DetailController extends GetxController {
  var service = Get.find<Service>();

  var detailRestaurant = DetailRestaurantResponse().obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = "".obs;
  var nameRestaurant = "".obs;
  var addressRestaurant = "".obs;
  var description = "".obs;
  var category = <Category>[].obs;
  var menu = Menus().obs;
  Dio dio = Dio();

  Future getDetailRestaurant(String id) async {
    dio = await service.createDio();
    isLoading(true);
    isError(false);
    try {
      Response response = await dio.get('/detail/$id');
      DetailRestaurantResponse responseBody = DetailRestaurantResponse.fromJson(response.data);
      nameRestaurant.value = responseBody.restaurant.name;
      addressRestaurant.value = responseBody.restaurant.address;
      description.value = responseBody.restaurant.description;
      category.value = responseBody.restaurant.categories;
      menu.value = responseBody.restaurant.menus;
    } catch (e) {
      if (e is DioError) {
        if (e.error is SocketException) {
          isError(true);
          errorMessage.value = "Connection Error";
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
