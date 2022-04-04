// import 'package:aiviewcloud/di/module/ws-discovery/BLOC.dart';
// import 'package:aiviewcloud/di/module/ws-discovery/Model/probe_match.dart';
// import 'package:aiviewcloud/di/module/ws-discovery/Model/sme_device.dart';
// import 'package:aiviewcloud/di/module/ws-discovery/Model/sme_device.dart';
// import 'package:aiviewcloud/di/module/ws-discovery/Repository/ParseData.dart';
// import 'package:aiviewcloud/di/module/ws-discovery/Repository/Utils.dart';

import 'package:aiviewcloud/di/module/ws-discovery/BLOC.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Model/probe_match.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Model/receive_envelope.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Model/sme_device.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Repository/ParseData.dart';

void readResponse(String probes) {
  final ReceiveEnvelope? aProbeMatch = readProbeMatches(probes);
  if (aProbeMatch != null) {
    ProbeMatch probeMatchObject = ProbeMatch(
        endpointReference:
            aProbeMatch.body!.probeMatches!.probeMatch!.endpointReference,
        types: aProbeMatch.body!.probeMatches!.probeMatch!.types,
        scopes: aProbeMatch.body!.probeMatches!.probeMatch!.scopes,
        xAddrs: aProbeMatch.body!.probeMatches!.probeMatch!.xAddrs,
        model: aProbeMatch.body!.probeMatches!.probeMatch!.model,
        serialNumber: aProbeMatch.body!.probeMatches!.probeMatch!.serialNumber,
        metadataVersion:
            aProbeMatch.body!.probeMatches!.probeMatch!.metadataVersion);
    probeMatchData.add(probeMatchObject);
  }
}

// Future<SmeDevice> processMatch(ProbeMatch aProbeMatch) async {
//   SmeDevice onvifDev = SmeDevice();
//   String aSystemDateAndTime =
//       await checkXAddrsAndGetTime(onvifDev, aProbeMatch, (device) {
//     onvifDev = device;
//   });
//   DateTime deviceTime = await parseSystemDateAndTime(aSystemDateAndTime);
//   return onvifDev;
// }

// Future<String> checkXAddrsAndGetTime(SmeDevice onvifDev,
//     ProbeMatch aProbeMatch, Function(SmeDevice) done) async {
//   for (String xAddr in aProbeMatch.xAddrs) {
//     String aSystemDateAndTime =
//         await onvifDev.getSystemDateAndTime(xaddr: xAddr);
//     if (aSystemDateAndTime != null) {
//       onvifDev.xAddr = xAddr;
//       done(onvifDev);
//       return aSystemDateAndTime;
//     }
//   }
//   return "";
// }
