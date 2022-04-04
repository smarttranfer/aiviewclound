import 'package:equatable/equatable.dart';

class EndpointReference extends Equatable {
  final String? address;

  const EndpointReference({this.address});

  factory EndpointReference.fromJson(Map<String, dynamic> json) =>
      EndpointReference(
        address: json['Address'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Address': address,
      };

  EndpointReference copyWith({
    String? address,
  }) {
    return EndpointReference(
      address: address ?? this.address,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [address];
}
