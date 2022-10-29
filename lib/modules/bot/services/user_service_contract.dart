import '../models/user.dart';

abstract class UserServiceContract {
  Future<User> connect(User user);
}