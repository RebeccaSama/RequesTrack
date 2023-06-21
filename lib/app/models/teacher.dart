import 'dart:convert';

class Teacher {
  String id;
  String first_name;
  String last_name;
  Teacher({
    required this.id,
    required this.first_name,
    required this.last_name,
  });

  Teacher copyWith({
    String? id,
    String? first_name,
    String? last_name,
  }) {
    return Teacher(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['_id'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) => Teacher.fromMap(json.decode(source));

  @override
  String toString() => 'Teacher(id: $id, first_name: $first_name, last_name: $last_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Teacher &&
      other.id == id &&
      other.first_name == first_name &&
      other.last_name == last_name;
  }

  @override
  int get hashCode => id.hashCode ^ first_name.hashCode ^ last_name.hashCode;
}
