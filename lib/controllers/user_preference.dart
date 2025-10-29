import '../constants.dart';
import '../models/AuthModel/user_model/user_model.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    logininfo.put('accessToken', responseModel.accessToken.toString());
    logininfo.put('refreshToken', responseModel.refreshToken.toString());
    logininfo.put('isLogin', responseModel.isLogin!);
    logininfo.put('role', responseModel.role!);
    logininfo.put('verified', responseModel.verified!);

    return true;
  }

  Future<UserModel> getUser() async {
    String? accessToken = logininfo.get('accessToken');
    String? refreshToken = logininfo.get('refreshToken');
    bool? isLogin = logininfo.get('isLogin');
    int? verified = logininfo.get('verified');
    String? role = logininfo.get('role');

    return UserModel(
      refreshToken: refreshToken,
      accessToken: accessToken,
      isLogin: isLogin,
      role: role,
      verified: verified,
    );
  }

  Future<bool> removeUser() async {
    logininfo.delete('refreshToken');
    logininfo.delete('accessToken');
    logininfo.delete('isLogin');
    logininfo.delete('role');
    logininfo.delete('verified');
    return true;
  }
}
