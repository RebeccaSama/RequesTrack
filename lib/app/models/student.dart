import 'dart:convert';

class Student {

  final String id;
  final String name;
  final String email;
  final String department;
  final String speciality;
  final String classroom;
  final String role;
  final String phone;
  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.speciality,
    required this.classroom,
    required this.role,
    required this.phone,
  });

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? speciality,
    String? classroom,
    String? role,
    String? phone,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      speciality: speciality ?? this.speciality,
      classroom: classroom ?? this.classroom,
      role: role ?? this.role,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'speciality': speciality,
      'classroom': classroom,
      'role': role,
      'phone': phone,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      department: map['department'] ?? '',
      speciality: map['speciality'] ?? '',
      classroom: map['classroom'] ?? '',
      role: map['role'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Student(id: $id, name: $name, email: $email, department: $department, speciality: $speciality, classroom: $classroom, role: $role, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Student &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.department == department &&
      other.speciality == speciality &&
      other.classroom == classroom &&
      other.role == role &&
      other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      department.hashCode ^
      speciality.hashCode ^
      classroom.hashCode ^
      role.hashCode ^
      phone.hashCode;
  }
}
