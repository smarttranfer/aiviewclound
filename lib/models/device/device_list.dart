import 'package:aiviewcloud/models/device/device.dart';

class DeviceList {
  final List<Device>? devices;

  DeviceList({
    this.devices,
  });

  factory DeviceList.fromJson(List<dynamic> json) {
    List<Device> devices = <Device>[];
    devices = json.map((device) => Device.fromMap(device)).toList();

    return DeviceList(
      devices: devices,
    );
  }
}
