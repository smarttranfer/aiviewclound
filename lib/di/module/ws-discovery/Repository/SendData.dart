import 'dart:io';

import 'package:dio/dio.dart';

import '../network_singleton.dart';

sendMulticast(String ip, int port, String message, Function(String) onDone) {
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 3702,
          reuseAddress: true, reusePort: true)
      .then((RawDatagramSocket socket) {
    InternetAddress multicastAddress = new InternetAddress(ip);
    int multicastPort = port;
    socket.listen((RawSocketEvent e) {
      Datagram? d = socket.receive();
      if (d == null) return;
      String messageRecived = new String.fromCharCodes(d.data);
      onDone(messageRecived.trim());
    });
    socket.send(message.codeUnits, multicastAddress, multicastPort);
  });

  // RawDatagramSocket.bind(InternetAddress.anyIPv4, 0,
  //         reuseAddress: false, reusePort: false)
  //     .then((RawDatagramSocket s) {
  //   s.send(message.codeUnits, multicastAddress, multicastPort);
  //   s.broadcastEnabled = true;

  //   s.listen((RawSocketEvent e) {
  //     print(e);
  //     Datagram? d = s.receive();
  //     print(d);
  //     if (d == null) return;
  //     String messageRecived = new String.fromCharCodes(d.data);
  //     onDone(messageRecived.trim());
  //   });
  // });
  // });
}

Future<String> httpPost(String url, String message) async {
  Response response;
  Dio dio = Dio();
  try {
    response = await dio.post(url, data: message);
  } catch (e) {
    return e.toString();
  }
  return response.data.toString();
}
