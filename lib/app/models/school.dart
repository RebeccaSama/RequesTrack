import 'dart:convert';

class School {
  String id;
  String name;
  School({
    required this.id,
    required this.name,
  });

  School copyWith({
    String? id,
    String? name,
  }) {
    return School(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory School.fromMap(dynamic map) {
    return School(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory School.fromJson(String source) => School.fromMap(json.decode(source));

  @override
  String toString() => 'School(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is School && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
