
import 'package:riverpod_demo/domain/models/otp_request.dart';
import 'package:riverpod_demo/domain/repository/auth_repository.dart';


class GenerateOtpUseCase {
  final AuthRepository repository;

  GenerateOtpUseCase(this.repository);

  Future<bool> call(OtpRequest request) {
    return repository.generateOtp(request);
  }
}
