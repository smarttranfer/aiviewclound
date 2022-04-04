import 'package:equatable/equatable.dart';

class UserToken extends Equatable {
  final int? id;
  final int? userId;
  final bool? isRememberPassword;
  final String? token;
  final dynamic jsonWebToken;
  final dynamic sessionState;
  final String? expiredDate;
  final String? createDate;
  final String? timeUpdateExpiredDateToDb;

  const UserToken({
    this.id,
    this.userId,
    this.isRememberPassword,
    this.token,
    this.jsonWebToken,
    this.sessionState,
    this.expiredDate,
    this.createDate,
    this.timeUpdateExpiredDateToDb,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) => UserToken(
        id: json['ID'] as int?,
        userId: json['UserID'] as int?,
        isRememberPassword: json['IsRememberPassword'] as bool?,
        token: json['Token'] as String?,
        jsonWebToken: json['JsonWebToken'] as String?,
        sessionState: json['SessionState'] as String?,
        expiredDate: json['ExpiredDate'] as String?,
        createDate: json['CreateDate'] as String?,
        timeUpdateExpiredDateToDb: json['TimeUpdateExpiredDateToDB'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'UserID': userId,
        'IsRememberPassword': isRememberPassword,
        'Token': token,
        'JsonWebToken': jsonWebToken,
        'SessionState': sessionState,
        'ExpiredDate': expiredDate,
        'CreateDate': createDate,
        'TimeUpdateExpiredDateToDB': timeUpdateExpiredDateToDb,
      };

  UserToken copyWith({
    int? id,
    int? userId,
    bool? isRememberPassword,
    String? token,
    dynamic jsonWebToken,
    dynamic sessionState,
    String? expiredDate,
    String? createDate,
    String? timeUpdateExpiredDateToDb,
  }) {
    return UserToken(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      isRememberPassword: isRememberPassword ?? this.isRememberPassword,
      token: token ?? this.token,
      jsonWebToken: jsonWebToken ?? this.jsonWebToken,
      sessionState: sessionState ?? this.sessionState,
      expiredDate: expiredDate ?? this.expiredDate,
      createDate: createDate ?? this.createDate,
      timeUpdateExpiredDateToDb:
          timeUpdateExpiredDateToDb ?? this.timeUpdateExpiredDateToDb,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      isRememberPassword,
      token,
      jsonWebToken,
      sessionState,
      expiredDate,
      createDate,
      timeUpdateExpiredDateToDb,
    ];
  }
}
