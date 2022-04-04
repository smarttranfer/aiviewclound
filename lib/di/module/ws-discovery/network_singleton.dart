import 'dart:io';

class MulticastClient {
  static RawDatagramSocket? _instance;

  static RawDatagramSocket? get instance => _instance;

  static Future<void> init() async {
    if (_instance == null) {
      _instance = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 3702,
          reuseAddress: true, reusePort: true);
    }
  }

  // static Future<void> destroy() async {
  //   _instance!.close();
  // }
}
