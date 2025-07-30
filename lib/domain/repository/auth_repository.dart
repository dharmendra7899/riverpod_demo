import 'package:riverpod_demo/domain/models/otp_request.dart';

abstract class AuthRepository {
  Future<bool> generateOtp(OtpRequest request);
}
