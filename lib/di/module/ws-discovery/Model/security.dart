import 'package:equatable/equatable.dart';

import 'username_token.dart';

class Security extends Equatable {
  final UsernameToken? usernameToken;

  const Security({this.usernameToken});

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        usernameToken: json['UsernameToken'] == null
            ? null
            : UsernameToken.fromJson(
                json['UsernameToken'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'UsernameToken': usernameToken?.toJson(),
      };

  Security copyWith({
    UsernameToken? usernameToken,
  }) {
    return Security(
      usernameToken: usernameToken ?? this.usernameToken,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [usernameToken];
}
