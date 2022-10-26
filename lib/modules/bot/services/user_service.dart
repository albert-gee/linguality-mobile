import 'package:linguality_mobile/modules/bot/services/user_service_contract.dart';

import '../models/user.dart';

class UserService implements UserServiceContract {
  @override
  Future<User> connect(User user) {
    // send init request to the API
    throw UnimplementedError();
  }
}