class OtpRequest {
  final String phoneNo;

  OtpRequest({required this.phoneNo});

  Map<String, dynamic> toJson() => {
    'phone_no': phoneNo,
  };
}

