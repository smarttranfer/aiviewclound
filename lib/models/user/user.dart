import 'package:aiviewcloud/models/country/country.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? accountId;
  final String? objectGuid;
  final int? userRegisterID;
  final String? email;
  final String? mobile;
  final String? userName;
  final String? fullName;
  final String? urlAvatar;
  final String? countriesCode;
  final Country? country;
  final bool? isActive;
  final bool? isDelete;
  final int? userIdCreate;
  final DateTime? createDate;
  final DateTime? lastUpdate;

  const User(
      {this.accountId,
      this.objectGuid,
      this.userRegisterID,
      this.fullName,
      this.email,
      this.mobile,
      this.userName,
      this.countriesCode,
      this.isActive,
      this.isDelete,
      this.userIdCreate,
      this.createDate,
      this.lastUpdate,
      this.urlAvatar,
      this.country});

  factory User.fromJson(Map<String, dynamic> json) => User(
        accountId: json['AccountID'] as int?,
        userRegisterID: json['UserRegisterID'] as int?,
        objectGuid: json['ObjectGuid'] as String?,
        email: json['Email'] as String?,
        fullName: json['FullName'] as String?,
        mobile: json['Mobile'] as String?,
        userName: json['UserName'] as String?,
        urlAvatar: json['UrlAvatar'] as String?,
        countriesCode: json['CountriesCode'] as String?,
        isActive: json['IsActive'] as bool?,
        isDelete: json['IsDelete'] as bool?,
        country: json['Countries'] != null
            ? Country.fromJson(json['Countries'])
            : null,
        userIdCreate: json['UserIDCreate'] as int?,
        createDate: json['CreateDate'] == null
            ? null
            : DateTime.parse(json['CreateDate'] as String),
        lastUpdate: json['LastUpdate'] == null
            ? null
            : DateTime.parse(json['LastUpdate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'AccountID': accountId,
        'ObjectGuid': objectGuid,
        'Email': email,
        'Mobile': mobile,
        'UserName': userName,
        'FullName': fullName,
        'CountriesCode': countriesCode,
        'IsActive': isActive,
        'IsDelete': isDelete,
        'UserIDCreate': userIdCreate,
        'CreateDate': createDate?.toIso8601String(),
        'LastUpdate': lastUpdate?.toIso8601String(),
        'UrlAvatar': urlAvatar
      };

  User copyWith({
    int? accountId,
    String? objectGuid,
    String? email,
    String? mobile,
    String? countriesCode,
    bool? isActive,
    bool? isDelete,
    int? userIdCreate,
    DateTime? createDate,
    DateTime? lastUpdate,
  }) {
    return User(
      accountId: accountId ?? this.accountId,
      objectGuid: objectGuid ?? this.objectGuid,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      userName: userName ?? this.userName,
      countriesCode: countriesCode ?? this.countriesCode,
      isActive: isActive ?? this.isActive,
      isDelete: isDelete ?? this.isDelete,
      userIdCreate: userIdCreate ?? this.userIdCreate,
      createDate: createDate ?? this.createDate,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      accountId,
      objectGuid,
      email,
      mobile,
      userName,
      countriesCode,
      isActive,
      fullName,
      isDelete,
      userIdCreate,
      createDate,
      lastUpdate,
    ];
  }
}
