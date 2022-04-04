import 'package:equatable/equatable.dart';

import 'probe_match.dart';

class ProbeMatches extends Equatable {
  final ProbeMatch? probeMatch;

  const ProbeMatches({this.probeMatch});

  factory ProbeMatches.fromJson(Map<String, dynamic> json) => ProbeMatches(
        probeMatch: json['ProbeMatch'] == null
            ? null
            : ProbeMatch.fromJson(json['ProbeMatch'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'ProbeMatch': probeMatch?.toJson(),
      };

  ProbeMatches copyWith({
    ProbeMatch? probeMatch,
  }) {
    return ProbeMatches(
      probeMatch: probeMatch ?? this.probeMatch,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [probeMatch];
}
