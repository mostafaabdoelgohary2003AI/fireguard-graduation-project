class UserModel {
  final int? id;
  final String? name; // mapped to username for legacy compatibility
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? token;
  final bool? isStuff;

  UserModel({
    this.id, 
    this.name, 
    this.firstName,
    this.lastName,
    this.email, 
    this.phone, 
    this.token, 
    this.isStuff
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Extract the user data safely (handles both full response and direct user object)
    final userData = json['user'] ?? json;
    final profileData = userData['profile'] as Map<String, dynamic>? ?? {};

    return UserModel(
      id: userData['id'],
      name: userData['username'] ?? userData['full_name'],
      firstName: userData['first_name'],
      lastName: userData['last_name'],
      email: userData['email'],
      // Safely access nested phone from profile, fallback to root
      phone: profileData['phone'] ?? userData['phone'],
      // Check root for token first, then fallback to user node
      token: json['token'] ?? json['access_token'] ?? userData['token'],
      // Default to false if null to prevent unexpected admin access
      isStuff: userData['is_staff'] ?? false,
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
