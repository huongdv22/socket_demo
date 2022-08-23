class UserInfo {
  final String name;
  final String gender;
  final String dob;
  final String email;
  final String phoneNumber;

  UserInfo({
    required this.name,
    required this.gender,
    required this.dob,
    required this.email,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'],
        gender: json['gender'],
        dob: json['dob'],
        email: json['otpType'],
        phoneNumber: json['phoneNumber'],
      );
}
