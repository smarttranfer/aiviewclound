String buildProbeMessage(String? messageID) {
  return '{"Envelope":{ "Header":{ "MessageID":"649B726A-D6A2-bf4b-B6CB-2C4F2C036A22", "To":"discovery", "Action":"discovery/Probe"},"Body":{"Probe":{"Types":"NetworkVideoTransmitter","Scopes":"Bkav"}}}}"';
  // Header header =
  //     Header(messageId: messageID, to: "discovery", action: "discovery/Probe");
  // Probe probe = Probe(types: "NetworkVideoTransmitter", scopes: "AIView");
  // SendBody body = SendBody(probe: probe);
  // return SendEnvelope(header: header, sendBody: body);
}

String buildGetSystemDateAndTimeMessage() {
  return '<?xml version="1.0" encoding="UTF-8"?>' +
      '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"' +
      'xmlns:tds="http://www.onvif.org/ver10/device/wsdl"> <SOAP-ENV:Body>' +
      '<tds:GetSystemDateAndTime/> </SOAP-ENV:Body>' +
      '</SOAP-ENV:Envelope>';
}

// String buildGetDeviceInformationMessage(
//     SMEDevice device, String username, String password) {
//   return '<?xml version="1.0" encoding="UTF-8"?>' +
//       '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"' +
//       'xmlns:tds="http://www.onvif.org/ver10/device/wsdl">' +
//       setAuthenticationInformation(device, username, password) +
//       '<SOAP-ENV:Body> <tds:GetDeviceInformation/>' +
//       '</SOAP-ENV:Body> </SOAP-ENV:Envelope>';
// }

// String buildGetCapabilitiesMessage(
//     SMEDevice device, String username, String password, String category) {
//   return '<?xml version="1.0" encoding="UTF-8"?>' +
//       '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"' +
//       'xmlns:tds="http://www.onvif.org/ver10/device/wsdl">' +
//       setAuthenticationInformation(device, username, password) +
//       '<SOAP-ENV:Body><tds:GetCapabilities>' +
//       '<tds:Category>$category</tds:Category>' +
//       '</tds:GetCapabilities> </SOAP-ENV:Body>' +
//       '</SOAP-ENV:Envelope>';
// }

// String setAuthenticationInformation(device, username, password) {
//   WsUsernameToken token = WsUsernameToken(username, password, device);
//   return '<SOAP-ENV:Header><Security s:mustUnderstand="1" xmlns="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">' +
//       '<UsernameToken><Username>${token.username}</Username>' +
//       '<Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordDigest">${token.password}</Password>' +
//       '<Nonce EncodingType="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-soap-message-security-1.0#Base64Binary">${token.nonce}</Nonce>' +
//       '<Created xmlns="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd">${token.created}</Created></UsernameToken></Security>' +
//       '</SOAP-ENV:Header>';
// }

// String buildGetNetworkProtocolsMessage(
//     SMEDevice device, String username, String password) {
//   return '<?xml version="1.0" encoding="utf-8"?>' +
//       '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:tt="http://www.onvif.org/ver10/schema">' +
//       setAuthenticationInformation(device, username, password) +
//       '<SOAP-ENV:Body><GetNetworkProtocols xmlns="http://www.onvif.org/ver10/device/wsdl" />' +
//       '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
// }

// String buildGetProfilesMessages(
//     SMEDevice device, String username, String password) {
//   return '<?xml version="1.0" encoding="UTF-8"?>' +
//       '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"' +
//       'xmlns:trt="http://www.onvif.org/ver10/media/wsdl">' +
//       setAuthenticationInformation(device, username, password) +
//       '<SOAP-ENV:Body><trt:GetProfiles/></SOAP-ENV:Body></SOAP-ENV:Envelope>';
// }

// String buildGetStreamUriMessage(
//     SMEDevice device,
//     String username,
//     String password,
//     Map<String, String?> streamSetup,
//     String targetProfileToken) {
//   return '<?xml version="1.0" encoding="utf-8"?>' +
//       '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://www.w3.org/2003/05/soap-envelope"' +
//       'xmlns:trt="http://www.onvif.org/ver10/media/wsdl" xmlns:tt="http://www.onvif.org/ver10/schema">' +
//       setAuthenticationInformation(device, username, password) +
//       '<SOAP-ENV:Body><trt:GetStreamUri>' +
//       '<trt:StreamSetup> <tt:Stream>${streamSetup['stream']}</tt:Stream><tt:Transport>' +
//       '<tt:Protocol>${streamSetup['protocol']}</tt:Protocol></tt:Transport></trt:StreamSetup>' +
//       '<trt:ProfileToken>$targetProfileToken</trt:ProfileToken></trt:GetStreamUri>' +
//       '</SOAP-ENV:Body></SOAP-ENV:Envelope>';
// }
