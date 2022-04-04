class Camera {
  String name;
  String id;

  Camera({
    required this.name,
    required this.id,
  });

  factory Camera.fromJson(Map<String, dynamic> json) => Camera(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  factory Camera.fromMap(Map<String, dynamic> json) => Camera(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
