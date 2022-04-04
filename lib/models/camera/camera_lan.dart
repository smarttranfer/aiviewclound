class LanCamera {
  String? manufacturer;
  String? model;
  String? firmwareVersion;
  String? serialNumber;
  String? hardwareId;
  String? rtsp_URL;

  LanCamera({
    required this.manufacturer,
    required this.model,
    required this.firmwareVersion,
    required this.serialNumber,
    required this.hardwareId,
    required this.rtsp_URL,
  });

  factory LanCamera.fromJson(Map<String, dynamic> json) => LanCamera(
        manufacturer: json['Manufacturer'] as String?,
        model: json['Model'] as String?,
        firmwareVersion: json['FirmwareVersion'] as String?,
        serialNumber: json['SerialNumber'] as String?,
        hardwareId: json['HardwareId'] as String?,
        rtsp_URL: json['RTSP_URL'] as String?,
      );

  // factory Camera.fromMap(Map<String, dynamic> json) => Camera(
  //       name: json["name"],
  //       id: json["id"], firmwareVersion: '',
  //     );

  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       "name": name,
  //     };
}
