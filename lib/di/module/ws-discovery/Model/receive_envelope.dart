import 'package:aiviewcloud/di/module/ws-discovery/Model/envelope.dart';
import 'body.dart';
import 'header.dart';

class ReceiveEnvelope extends Envelope {
  final Body? body;
  const ReceiveEnvelope({header, this.body}) : super(header: header);

  factory ReceiveEnvelope.fromJson(Map<String, dynamic> json) =>
      ReceiveEnvelope(
        header: json['Header'] == null
            ? null
            : Header.fromJson(json['Header'] as Map<String, dynamic>),
        body: json['Body'] == null
            ? null
            : Body.fromJson(json['Body'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'Header': header?.toJson(),
        'Body': body?.toJson(),
      };

  ReceiveEnvelope copyWith({
    Header? header,
    Body? body,
  }) {
    return ReceiveEnvelope(
        header: header ?? this.header, body: body ?? this.body);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [header, body];
}
