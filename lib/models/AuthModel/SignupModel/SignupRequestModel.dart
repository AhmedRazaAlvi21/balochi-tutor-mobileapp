class SignupRequestModel {
  String? deviceToken;
  String? userImg;
  String? name;
  String? email;
  int? age;
  String? password;

  SignupRequestModel({
    this.deviceToken,
    this.userImg,
    this.name,
    this.email,
    this.age,
    this.password,
  });

  SignupRequestModel.fromJson(Map<String, dynamic> json) {
    deviceToken = json['device_token'];
    userImg = json['user_img'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['device_token'] = deviceToken;
    data['user_img'] = userImg;
    data['name'] = name;
    data['email'] = email;
    data['age'] = age;
    data['password'] = password;
    return data;
  }
}
