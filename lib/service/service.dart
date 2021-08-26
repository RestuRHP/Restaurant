import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Service extends GetxController {
  String debugUrl = "https://restaurant-api.dicoding.dev/";

  Future<Dio> createDio() async {
    var dio = Dio(BaseOptions(
      baseUrl: debugUrl,
      contentType: "application/x-www-form-urlencoded | application/json",
      headers: {"Accept": "application/json"},
      receiveTimeout: 3000,
    ));

    /// customization
    dio.interceptors.add(PrettyDioLogger(

        ///requestHeader: true,
        requestBody: true,
        responseBody: true,

        ///responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 150));
    return dio;
  }
}
