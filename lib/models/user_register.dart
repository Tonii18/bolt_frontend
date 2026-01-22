class UserRegister {
  final String fullname;
  final String email;
  final String phone;
  final String password;

  UserRegister({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullname,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
