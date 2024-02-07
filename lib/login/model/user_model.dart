class UserModel {
  final String type;
  final String identification;
  final String password;

  UserModel({
    required this.type,
    required this.identification,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      type: json['type'],
      identification: json['identification'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'identification': identification,
      'password': password,
    };
  }
}
