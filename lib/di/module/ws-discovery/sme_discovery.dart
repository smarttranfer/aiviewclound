import 'package:aiviewcloud/di/module/ws-discovery/Repository/SendData.dart';
import 'BLOC.dart';
import 'Model/Probe.dart';
import 'Model/probe_match.dart';
import 'Repository/ProcessResponse.dart';
import 'Repository/Utils.dart';
import 'Repository/buildMessages.dart';

class SMEWS {
  void getDevices(Function(List<ProbeMatch?>) onDone) async {
    List<ProbeMatch?> probeMatchList = [];
    var uuid = getUUID();
    String message = buildProbeMessage(uuid);
    sendMulticast("239.255.255.250", 3702, message, (messageRecivied) {
      probeData.add(messageRecivied);
    });
    Probe.netHandle.listen((inComingProbe) {
      if (inComingProbe != null) {
        readResponse(inComingProbe);
        probeMatchData.probeMatches.listen((inComingProbeMatch) async {
          if (!inlist(probeMatchList, inComingProbeMatch)) {
            probeMatchList.add(inComingProbeMatch);
            onDone(probeMatchList);
          }
        });
      }
    });
  }

  // Future<SMEDevice> _updateCapabilities(
  //     String username, String password, SMEDevice device) async {
  //   String message =
  //       buildGetDeviceInformationMessage(device, username, password);
  //   String information = await httpPost(device.xAddr!, message);
  //   Map<String, String> deviceInformation =
  //       parseGetDeviceInformation(information);
  //   device.serial = deviceInformation['serialNumber'];
  //   device.model = deviceInformation['model'];
  //   message = buildGetCapabilitiesMessage(device, username, password, "All");
  //   information = await httpPost(device.xAddr!, message);
  //   Map<String, String> capablities = parseGetCapabilities(information);
  //   device.xAddr = capablities['XAddr'];
  //   device.eventsXAddr = capablities['Events'];
  //   device.mediaXAddr = capablities['Media'];
  //   return device;
  // }

  // Future<String> getCameraUri(
  //     SMEDevice device, String username, String password) async {
  //   device = await _updateCapabilities(username, password, device);
  //   List<NetworkProtocol> networkProtocols =
  //       await _getNetworkProtocols(device, username, password);
  //   for (NetworkProtocol networkProtocol in networkProtocols) {
  //     if (networkProtocol.name == "HTTPS") {
  //       networkProtocol.enabled = true;
  //       networkProtocol.port = 443;
  //     }
  //   }
  //   String message = buildGetProfilesMessages(device, username, password);
  //   String profiles = await httpPost(device.mediaXAddr!, message);
  //   List<String> profileList = parseGetProfiles(profiles);
  //   String targetProfileToken = profileList.last;
  //   Map<String, String?> streamSetup = <String, String?>{};
  //   streamSetup["stream"] = "RTP-Unicast";
  //   streamSetup["protocol"] = "HTTP";
  //   streamSetup["tunnel"] = null;
  //   message = buildGetStreamUriMessage(
  //       device, username, password, streamSetup, targetProfileToken);
  //   String result = await httpPost(device.mediaXAddr!, message);
  //   return parseGetMediaUri(result);
  // }

  // Future<List<NetworkProtocol>> _getNetworkProtocols(
  //     SMEDevice device, String username, String password) async {
  //   String message =
  //       buildGetNetworkProtocolsMessage(device, username, password);
  //   final info = await httpPost(device.xAddr!, message);
  //   return parseGetNetworkProtocols(info);
  // }
}
