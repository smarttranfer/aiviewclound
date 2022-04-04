import 'package:aiviewcloud/models/peer/peer.dart';
import 'package:aiviewcloud/models/user/user.dart';
import 'package:aiviewcloud/models/user_token/user_token.dart';
import 'package:equatable/equatable.dart';

class LoginObject extends Equatable {
  final User? user;
  final UserToken? userToken;
  final Peer? peer;

  const LoginObject({this.user, this.userToken, this.peer});

  factory LoginObject.fromJson(Map<String, dynamic> json) => LoginObject(
        user: User.fromJson(json['User']),
        userToken: UserToken.fromJson(json['UserToken']),
        peer: Peer.fromJson(json['peer']),
      );

  Map<String, dynamic> toJson() =>
      {'User': user, 'UserToken': userToken, 'Peer': peer};

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [user, userToken, peer];
  }
}
