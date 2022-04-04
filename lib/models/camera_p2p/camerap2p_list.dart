import 'camera_p2p.dart';

class CameraP2PList {
  List<CameraP2P?> list;

  CameraP2PList({
    required this.list,
  });

  factory CameraP2PList.fromJson(List<dynamic> json) {
    List<CameraP2P> list = <CameraP2P>[];
    list = json.map((cameraP2P) => CameraP2P.fromJson(cameraP2P)).toList();

    return CameraP2PList(
      list: list,
    );
  }
}
