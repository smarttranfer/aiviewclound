import 'package:aiviewcloud/models/camera/camera_lan.dart';

import 'cam.dart';

class CamList {
  final List<Camera>? cameras;

  CamList({
    this.cameras,
  });

  factory CamList.fromJson(List<dynamic> json) {
    List<Camera> cameras = <Camera>[];
    cameras = json.map((camera) => Camera.fromMap(camera)).toList();

    return CamList(
      cameras: cameras,
    );
  }
}
