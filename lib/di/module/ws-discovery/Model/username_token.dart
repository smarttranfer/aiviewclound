import 'package:equatable/equatable.dart';

class UsernameToken extends Equatable {
  final String? username;
  final String? password;
  final String? nonce;
  final String? created;

  const UsernameToken({
    this.username,
    this.password,
    this.nonce,
    this.created,
  });

  factory UsernameToken.fromJson(Map<String, dynamic> json) => UsernameToken(
        username: json['Username'] as String?,
        password: json['Password'] as String?,
        nonce: json['Nonce'] as String?,
        created: json['Created'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'Username': username,
        'Password': password,
        'Nonce': nonce,
        'Created': created,
      };

  UsernameToken copyWith({
    String? username,
    String? password,
    String? nonce,
    String? created,
  }) {
    return UsernameToken(
      username: username ?? this.username,
      password: password ?? this.password,
      nonce: nonce ?? this.nonce,
      created: created ?? this.created,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username, password, nonce, created];
}
