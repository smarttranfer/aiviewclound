import 'package:equatable/equatable.dart';

import '../BLOC.dart';

class Probe extends Equatable {
  final String? types;
  final String? scopes;
  static Stream<String?> netHandle = probeData.probes;

  const Probe({this.types, this.scopes});

  factory Probe.fromJson(Map<String, dynamic> json) => Probe(
        types: json['Types'] as String?,
        scopes: json['Scopes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Types': types,
        'Scopes': scopes,
      };

  Probe copyWith({
    String? types,
    String? scopes,
  }) {
    return Probe(
      types: types ?? this.types,
      scopes: scopes ?? this.scopes,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [types, scopes];
}
