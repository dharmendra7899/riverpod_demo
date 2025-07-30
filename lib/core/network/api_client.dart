import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  factory ApiClient.create() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.policyvault.in/api/v1.0/',
      contentType: 'application/json',
    ));

    return ApiClient(dio);
  }
}
