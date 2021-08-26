import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:submission_fudamental_flutter/data/model/restaurant_list_response.dart';
import 'package:submission_fudamental_flutter/service/service.dart';

class HomeController extends GetxController {
  TextEditingController search = TextEditingController();

  var service = Get.find<Service>();
  var listRestaurant = RestaurantListResponse().obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;
  var isError = false.obs;
  Dio dio = Dio();

  @override
  void onInit() {
    getListRestaurant();
    super.onInit();
  }

  Future getListRestaurant() async {
    dio = await service.createDio();
    isLoading(true);
    isError(false);
    try {
      Response response = await dio.get('/list');
      RestaurantListResponse responseBody = RestaurantListResponse.fromJson(response.data);
      listRestaurant.value = responseBody;
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

  Future searchRestaurant(String query) async {
    dio = await service.createDio();
    isLoading(true);
    isError(false);
    try {
      Response response = await dio.get('//search?q=$query');
      RestaurantListResponse responseBody = RestaurantListResponse.fromJson(response.data);
      listRestaurant.value = responseBody;
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
