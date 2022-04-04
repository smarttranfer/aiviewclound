import 'package:aiviewcloud/di/module/ws-discovery/Model/probe.dart';
import 'package:equatable/equatable.dart';

class SendBody extends Equatable {
  final Probe? probe;

  const SendBody({required this.probe});

  factory SendBody.fromJson(Map<String, dynamic> json) => SendBody(
        probe: Probe.fromJson(json['Probe'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'Probe': probe?.toJson(),
      };

  SendBody copyWith({
    Probe? probe,
  }) {
    return SendBody(
      probe: probe ?? this.probe,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [probe];
}
