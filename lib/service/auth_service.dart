import 'package:dio/dio.dart';
import 'package:riverpod_demo/core/network/api_client.dart';
import 'package:riverpod_demo/domain/models/otp_request.dart';

class AuthService {
  final ApiClient client;

  AuthService(this.client);

  Future<Response> generateOtp(OtpRequest phoneNo) async {
    return client.dio.post('users/generateotp/', data: phoneNo.toJson());
  }
}
