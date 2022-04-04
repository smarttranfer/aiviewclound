class CameraDetails {
  String cameraName;
  String regionName;
  String? seriNumber;

  CameraDetails({
    this.cameraName = '',
    this.regionName = '',
    required this.seriNumber,
  });

  factory CameraDetails.fromJson(Map<String, dynamic> json) => CameraDetails(
        cameraName: json['CameraName'] == null ? '' : json['CameraName'],
        regionName:
            json['RegionName'] == null ? '' : json['RegionName'] as String,
        seriNumber: json['SeriNumber'] as String?,
      );

  factory CameraDetails.fromMap(Map<String, dynamic> json) => CameraDetails(
        cameraName: json['CameraName'],
        regionName: json['RegionName'],
        seriNumber: json['SeriNumber'],
      );

  Map<String, dynamic> toMap() => {
        "CameraName": cameraName,
        "RegionName": regionName,
        "SeriNumber": seriNumber,
      };
}
