import 'package:riverpod_demo/domain/models/otp_request.dart';
import 'package:riverpod_demo/domain/repository/auth_repository.dart';
import 'package:riverpod_demo/service/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<bool> generateOtp(OtpRequest request) async {
    final response = await service.generateOtp(request);
    return response.statusCode == 200 && response.data['status'] == true;
  }
}
