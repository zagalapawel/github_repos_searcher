import 'package:domain/model/user.dart';
import 'package:remote/mapper/mapper.dart';
import 'package:remote/models/user_remote_model.dart';

class UserRemoteToDomainMapper implements Mapper<UserRemoteModel, User> {
  const UserRemoteToDomainMapper();

  @override
  User map(UserRemoteModel element) => User(
        id: element.id,
        login: element.login,
        avatarUrl: element.avatarUrl,
      );
}
