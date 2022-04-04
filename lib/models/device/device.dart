class Device {
  String? model;
  String? seri;
  String? id;

  Device({
    this.model,
    this.seri,
    this.id,
  });

  factory Device.fromMap(Map<String, dynamic> json) => Device(
        model: json["model"],
        seri: json["seri"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "model": model,
        "id": id,
        "seri": seri,
      };
}
