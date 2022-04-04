import 'package:equatable/equatable.dart';

import 'endpoint_reference.dart';

class ProbeMatch extends Equatable {
  final EndpointReference? endpointReference;
  final String? types;
  final String? scopes;
  final String? xAddrs;
  final String? model;
  final String? serialNumber;
  final int? metadataVersion;

  const ProbeMatch({
    this.endpointReference,
    this.types,
    this.scopes,
    this.xAddrs,
    this.model,
    this.serialNumber,
    this.metadataVersion,
  });

  factory ProbeMatch.fromJson(Map<String, dynamic> json) => ProbeMatch(
        endpointReference: json['EndpointReference'] == null
            ? null
            : EndpointReference.fromJson(
                json['EndpointReference'] as Map<String, dynamic>),
        types: json['Types'] as String?,
        scopes: json['Scopes'] as String?,
        xAddrs: json['XAddrs'] as String?,
        model: json['Model'] as String?,
        serialNumber: json['SerialNumber'] as String?,
        metadataVersion: json['MetadataVersion'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'EndpointReference': endpointReference?.toJson(),
        'Types': types,
        'Scopes': scopes,
        'XAddrs': xAddrs,
        'Model': model,
        'SerialNumber': serialNumber,
        'MetadataVersion': metadataVersion,
      };

  ProbeMatch copyWith({
    EndpointReference? endpointReference,
    String? types,
    String? scopes,
    String? xAddrs,
    String? model,
    String? serialNumber,
    int? metadataVersion,
  }) {
    return ProbeMatch(
      endpointReference: endpointReference ?? this.endpointReference,
      types: types ?? this.types,
      scopes: scopes ?? this.scopes,
      xAddrs: xAddrs ?? this.xAddrs,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      metadataVersion: metadataVersion ?? this.metadataVersion,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      endpointReference,
      types,
      scopes,
      xAddrs,
      model,
      serialNumber,
      metadataVersion,
    ];
  }
}
