class SourceMod {
  SourceMod({this.id = '', required this.name});

  String? id, name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SourceMod.fromJson(Map<String, dynamic> json) {
    return SourceMod(
      id: json['id'],
      name: json['name'],
    );
  }
}

