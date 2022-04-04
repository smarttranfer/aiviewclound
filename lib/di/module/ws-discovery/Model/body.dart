import 'package:equatable/equatable.dart';

import 'probe_matches.dart';

class Body extends Equatable {
  final ProbeMatches? probeMatches;

  const Body({this.probeMatches});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
        probeMatches: json['ProbeMatches'] == null
            ? null
            : ProbeMatches.fromJson(
                json['ProbeMatches'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'ProbeMatches': probeMatches?.toJson(),
      };

  Body copyWith({
    ProbeMatches? probeMatches,
  }) {
    return Body(
      probeMatches: probeMatches ?? this.probeMatches,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [probeMatches];
}
