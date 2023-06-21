import 'dart:convert';

class User {

  final String id;
  final String name;
  final String email;
  final String role;
  final String phone;
  final String userData;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.userData,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? userData,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      userData: userData ?? this.userData,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'userData': userData,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      phone: map['phone'] ?? '',
      userData: map['userData'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role, phone: $phone, userData: $userData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.role == role &&
      other.phone == phone &&
      other.userData == userData;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode ^
      phone.hashCode ^
      userData.hashCode;
  }
}
