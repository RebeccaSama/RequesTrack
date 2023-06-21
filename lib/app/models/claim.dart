import 'dart:convert';

class Claim {

  String id;
  String name;
  Claim({
    required this.id,
    required this.name,
  });

  Claim copyWith({
    String? id,
    String? name,
  }) {
    return Claim(
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

  factory Claim.fromMap(Map<String, dynamic> map) {
    return Claim(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Claim.fromJson(String source) => Claim.fromMap(json.decode(source));

  @override
  String toString() => 'Claim(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Claim &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
