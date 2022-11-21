abstract class AuthServiceContract {

  Future<String?> getAccessToken();

  Future<bool> authenticate();
}