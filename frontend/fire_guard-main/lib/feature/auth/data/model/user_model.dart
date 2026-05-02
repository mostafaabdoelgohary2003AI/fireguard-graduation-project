class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['username'] ?? json['full_name'],
      email: json['email'],
      phone: (json['profile'] as Map<String, dynamic>?)?['phone'] as String?,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'phone': phone,
      'token': token,
    };
  }
}
