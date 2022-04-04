import 'package:equatable/equatable.dart';

class CameraP2P extends Equatable {
  final int? cameraId;
  final String? objectGuid;
  final String? cameraName;
  final int? userIdCreate;
  final dynamic serial;
  final String? secureCode;
  final String? snapShotUrl;
  final bool? isDelete;
  final DateTime? lastUpdate;
  final DateTime? createDate;
  final String? peerId;
  final bool isConnected;
  final bool isPTZ;
  bool isSelected;
  CameraP2P(
      {this.objectGuid,
      this.cameraName,
      this.userIdCreate,
      this.serial,
      this.secureCode,
      this.isDelete,
      this.snapShotUrl,
      this.lastUpdate,
      this.createDate,
      this.peerId,
      this.cameraId,
      this.isPTZ = false,
      this.isConnected = false,
      this.isSelected = false});
  set selected(bool isSelected) {
    this.isSelected = isSelected;
  }

  factory CameraP2P.fromJson(Map<String, dynamic> json) => CameraP2P(
        cameraId: json['CameraID'] as int?,
        objectGuid: json['ObjectGuid'] as String?,
        snapShotUrl: json['SnapShotUrl'] as String?,
        cameraName: json['CameraName'],
        userIdCreate: json['UserIDCreate'] as int?,
        serial: json['Serial'],
        isConnected: json['IsConnected'],
        isPTZ: json['IsPTZ'],
        secureCode: json['SecureCode'] as String?,
        peerId: json['PeerId'] as String?,
        isDelete: json['IsDelete'] as bool?,
        lastUpdate: json['LastUpdate'] == null
            ? null
            : DateTime.parse(json['LastUpdate'] as String),
        createDate: json['CreateDate'] == null
            ? null
            : DateTime.parse(json['CreateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'CameraID': cameraId,
        'ObjectGuid': objectGuid,
        'CameraName': cameraName,
        'SnapShotUrl': snapShotUrl,
        'UserIDCreate': userIdCreate,
        'Serial': serial,
        'IsPTZ': isPTZ,
        'SecureCode': secureCode,
        'IsDelete': isDelete,
        'PeerId': peerId,
        'LastUpdate': lastUpdate?.toIso8601String(),
        'CreateDate': createDate?.toIso8601String(),
      };

  CameraP2P copyWith(
      {String? objectGuid,
      dynamic cameraName,
      int? userIdCreate,
      dynamic serial,
      String? secureCode,
      bool? isDelete,
      DateTime? lastUpdate,
      DateTime? createDate,
      String? peerId}) {
    return CameraP2P(
      objectGuid: objectGuid ?? this.objectGuid,
      cameraName: cameraName ?? this.cameraName,
      userIdCreate: userIdCreate ?? this.userIdCreate,
      peerId: peerId ?? this.peerId,
      serial: serial ?? this.serial,
      secureCode: secureCode ?? this.secureCode,
      isDelete: isDelete ?? this.isDelete,
      isConnected: this.isConnected,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      objectGuid,
      cameraName,
      userIdCreate,
      serial,
      snapShotUrl,
      secureCode,
      isDelete,
      lastUpdate,
      createDate,
      peerId
    ];
  }
}
