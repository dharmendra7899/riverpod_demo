import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_demo/domain/models/otp_request.dart';
import 'package:riverpod_demo/domain/usecase/generate_otp_usecase.dart';

class AuthViewModel extends ChangeNotifier {
  final GenerateOtpUseCase generateOtpUseCase;

  AuthViewModel(this.generateOtpUseCase);

  bool _loading = false;

  bool get loading => _loading;

  String? _error;

  String? get error => _error;

  Future<bool> generateOtp(OtpRequest phone) async {
    _loading = true;
    _error = null;
    notifyListeners();

    bool result = false;

    try {
      result = await generateOtpUseCase(phone);
      if (!result) {
        _error = 'OTP generation failed';
      }
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Something went wrong';
        debugPrint('HTTP $statusCode: $message');
        _error = 'Error: $message';
      } else {
        _error = 'Unexpected error: ${e.toString()}';
      }
    } finally {
      _loading = false;
      notifyListeners();
    }

    return result;
  }
}
