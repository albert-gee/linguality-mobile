import 'package:linguality_mobile/utils/auth/auth_service_contract.dart';

class TestAuthService extends AuthServiceContract{

  @override
  Future<String?> getAccessToken() async {
    return 'token';
  }

  @override
  Future<bool> authenticate() async {
    return true;
  }
}
