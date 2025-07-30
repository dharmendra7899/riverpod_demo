import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  factory ApiClient.create() {
    final dio = Dio(BaseOptions(
      ///change your domain here
      baseUrl: 'https://www.google.com/api/v1.0/',
      contentType: 'application/json',
    ));

    return ApiClient(dio);
  }
}
