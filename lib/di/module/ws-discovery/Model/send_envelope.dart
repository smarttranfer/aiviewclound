import 'package:aiviewcloud/di/module/ws-discovery/Model/envelope.dart';
import 'package:aiviewcloud/di/module/ws-discovery/Model/send_body.dart';
import 'package:equatable/equatable.dart';

import 'body.dart';
import 'header.dart';

class SendEnvelope extends Envelope {
  final SendBody? sendBody;
  const SendEnvelope({header, this.sendBody}) : super(header: header);

  factory SendEnvelope.fromJson(Map<String, dynamic> json) => SendEnvelope(
        header: json['Header'] == null
            ? null
            : Header.fromJson(json['Header'] as Map<String, dynamic>),
        sendBody: json['SendBody'] == null
            ? null
            : SendBody.fromJson(json['SendBody'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "Envelope": {
          "Header": header?.toJson(),
          "Body": sendBody?.toJson(),
        }
      };

  SendEnvelope copyWith({
    Header? header,
    SendBody? sendBody,
  }) {
    return SendEnvelope(
        header: header ?? this.header, sendBody: sendBody ?? this.sendBody);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [header, sendBody];
}
