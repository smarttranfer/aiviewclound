import 'package:aiviewcloud/di/module/ws-discovery/Model/send_body.dart';
import 'package:equatable/equatable.dart';

import 'body.dart';
import 'header.dart';

class Envelope extends Equatable {
  final Header? header;
  final Body? body;
  final SendBody? sendBody;
  const Envelope({this.header, this.body, this.sendBody});

  factory Envelope.fromJson(Map<String, dynamic> json) => Envelope(
        header: json['Header'] == null
            ? null
            : Header.fromJson(json['Header'] as Map<String, dynamic>),
        body: json['Body'] == null
            ? null
            : Body.fromJson(json['Body'] as Map<String, dynamic>),
        sendBody: json['SendBody'] == null
            ? null
            : SendBody.fromJson(json['SendBody'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'Header': header?.toJson(),
        'Body': body?.toJson(),
        'SendBody': sendBody?.toJson(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [header, body, sendBody];
}
