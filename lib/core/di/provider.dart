import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/core/network/api_client.dart';
import 'package:riverpod_demo/data/repository_imp/auth_repository.dart';
import 'package:riverpod_demo/domain/repository/auth_repository.dart';
import 'package:riverpod_demo/domain/usecase/generate_otp_usecase.dart';
import 'package:riverpod_demo/presentation/viewmodel/auth_view_model.dart';
import 'package:riverpod_demo/service/auth_service.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient.create();
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authServiceProvider));
});

final generateOtpUseCaseProvider = Provider<GenerateOtpUseCase>((ref) {
  return GenerateOtpUseCase(ref.read(authRepositoryProvider));
});

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel(ref.read(generateOtpUseCaseProvider));
});
