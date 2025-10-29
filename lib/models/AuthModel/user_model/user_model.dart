class UserModel {
  String? accessToken;
  String? refreshToken;
  bool? isLogin;
  String? role;
  int? verified;

  UserModel({this.isLogin, this.refreshToken, this.accessToken, this.role, this.verified});

  UserModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    isLogin = json['isLogin'];
    role = json['role'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['isLogin'] = this.isLogin;
    data['role'] = this.role;
    data['verified'] = this.verified;
    return data;
  }
}
