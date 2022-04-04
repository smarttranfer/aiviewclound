import 'package:shared_preferences/shared_preferences.dart';

class Endpoints {
  Endpoints._();
  static EnvMode mode = EnvMode.production;
  // base url
  static String baseUrl = mode == EnvMode.qa
      ? "https://psslmdev.hcdt.vn/api/"
      : "http:/slmav.aiview.ai/api/";
  static String baseP2PUrl = mode == EnvMode.qa
      ? "http://psp2pdev.bkav.com:30003/p2p/api/sample/"
      : "https://ppbs.aiview.ai:30004/p2p/api/sample/";
  static String clientId = mode == EnvMode.qa
      ? "60ed47aced5113190cde57f6"
      : "616fbc58773c9c73124d5baf";

  // static String prod_baseUrl = "https:/slmav.aiview.ai/api/";
  // static String prod_baseP2PUrl =
  //     "https://ppbs.aiview.ai:30004/p2p/api/sample/";
  // static String prod_clientId = "616fbc58773c9c73124d5baf";
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static void initEnvMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localMode = prefs.getString('EnvMode');
    if (localMode != null) {
      mode =
          localMode == EnvMode.qa.toString() ? EnvMode.qa : EnvMode.production;
      baseUrl = localMode == EnvMode.qa.toString()
          ? "https://psslmdev.hcdt.vn/api/"
          : "http:/slmav.aiview.ai/api/";
      baseP2PUrl = localMode == EnvMode.qa.toString()
          ? "http://psp2pdev.bkav.com:30003/p2p/api/sample/"
          : "https://ppbs.aiview.ai:30004/p2p/api/sample/";
      clientId = localMode == EnvMode.qa.toString()
          ? "60ed47aced5113190cde57f6"
          : "616fbc58773c9c73124d5baf";
    }
  }

  static String get getUrlEndPoint {
    return mode == EnvMode.qa
        ? "https://psslmdev.hcdt.vn/api/"
        : "https://slmav.aiview.ai/api/";
  }

  static String get getP2PUrlEndPoint {
    return mode == EnvMode.qa
        ? "https://psppdev.hcdt.vn:30004/p2p/api/sample/"
        : "https://ppbs.aiview.ai:30004/p2p/api/sample/";
  }

  static String get getClientId {
    return mode == EnvMode.qa
        ? "60ed47aced5113190cde57f6"
        : "616fbc58773c9c73124d5baf";
  }

  // booking endpoints
  static String getPosts = baseUrl + "/posts";
}

enum EnvMode {
  production,
  qa,
}
