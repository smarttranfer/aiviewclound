import 'package:equatable/equatable.dart';

class Probe extends Equatable {
  final String? types;
  final String? scopes;

  const Probe({this.types, this.scopes});

  factory Probe.fromJson(Map<String, dynamic> json) => Probe(
        types: json['Types'] as String?,
        scopes: json['Scopes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Types': types,
        'Scopes': scopes,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [types, scopes];
}
