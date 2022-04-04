import 'package:equatable/equatable.dart';

class SmeDevice extends Equatable {
  final String? manufacturer;
  final String? model;
  final String? firmwareVersion;
  final String? serialNumber;
  final String? hardwareId;
  final String? rtspUrl;

  const SmeDevice({
    this.manufacturer,
    this.model,
    this.firmwareVersion,
    this.serialNumber,
    this.hardwareId,
    this.rtspUrl,
  });

  factory SmeDevice.fromJson(Map<String, dynamic> json) => SmeDevice(
        manufacturer: json['Manufacturer'] as String?,
        model: json['Model'] as String?,
        firmwareVersion: json['FirmwareVersion'] as String?,
        serialNumber: json['SerialNumber'] as String?,
        hardwareId: json['HardwareId'] as String?,
        rtspUrl: json['RTSP_URL'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Manufacturer': manufacturer,
        'Model': model,
        'FirmwareVersion': firmwareVersion,
        'SerialNumber': serialNumber,
        'HardwareId': hardwareId,
        'RTSP_URL': rtspUrl,
      };

  SmeDevice copyWith({
    String? manufacturer,
    String? model,
    String? firmwareVersion,
    String? serialNumber,
    String? hardwareId,
    String? rtspUrl,
  }) {
    return SmeDevice(
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
      serialNumber: serialNumber ?? this.serialNumber,
      hardwareId: hardwareId ?? this.hardwareId,
      rtspUrl: rtspUrl ?? this.rtspUrl,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      manufacturer,
      model,
      firmwareVersion,
      serialNumber,
      hardwareId,
      rtspUrl,
    ];
  }
}
