import 'package:aiviewcloud/di/module/ws-discovery/Model/security.dart';
import 'package:equatable/equatable.dart';

class Header extends Equatable {
  final String? messageId;
  final String? relatesTo;
  final String? to;
  final String? action;
  final Security? security;
  const Header(
      {this.messageId, this.relatesTo, this.to, this.action, this.security});

  factory Header.fromJson(Map<String, dynamic> json) => Header(
        messageId: json['MessageID'] as String?,
        relatesTo: json['RelatesTo'] as String?,
        to: json['To'] as String?,
        action: json['Action'] as String?,
        security: json['Security'] as Security?,
      );

  Map<String, dynamic> toJson() => {
        'MessageID': messageId,
        'RelatesTo': relatesTo,
        'To': to,
        'Action': action,
        'Security': security
      };

  Header copyWith(
      {String? messageId,
      String? relatesTo,
      String? to,
      String? action,
      Security? security}) {
    return Header(
        messageId: messageId ?? this.messageId,
        relatesTo: relatesTo ?? this.relatesTo,
        to: to ?? this.to,
        action: action ?? this.action,
        security: security ?? this.security);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [messageId, relatesTo, to, action, security];
}
