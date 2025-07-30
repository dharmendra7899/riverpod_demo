import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/core/di/provider.dart';
import 'package:riverpod_demo/domain/models/otp_request.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      _showSnack("Phone number is required", isError: true);
      return;
    }

    final isValidPhone = RegExp(r'^\d{10}$').hasMatch(phone);
    if (!isValidPhone) {
      _showSnack("Please enter a valid 10-digit phone number", isError: true);
      return;
    }

    final request = OtpRequest(phoneNo: phone);
    final viewModel = ref.read(authViewModelProvider);

    final success = await viewModel.generateOtp(request);

    if (success) {
      _showSnack("OTP sent successfully");
    } else {
      final error = ref.read(authViewModelProvider).error ?? 'Unknown error';
      _showSnack(error, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Generate OTP",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Welcome to RiverPod Demo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              "Enter your mobile number to proceed",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 26),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 34, vertical: 4),
                  ),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.blueGrey,
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                onPressed: viewModel.loading ? null : _handleSubmit,
                child: viewModel.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 4,
                          backgroundColor: Colors.green,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blueGrey,
                          ),
                        ),
                      )
                    : const Text(
                        "Generate OTP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
