class UserProfileResponseModel {
  bool? success;
  String? message;
  int? code;
  UserProfileData? data;

  UserProfileResponseModel({this.success, this.message, this.code, this.data});

  UserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? UserProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserProfileData {
  int? id;
  String? name;
  String? email;
  int? stripeCustomerId;
  String? defaultPaymentMethod;
  String? emailVerifiedAt;
  int? age;
  String? createdAt;
  String? updatedAt;
  int? coupon;
  int? isPremium;
  String? userImg;
  String? role;
  String? deviceToken;
  String? code;
  String? codeGeneratedAt;
  int? verified;
  int? status;
  String? fcmToken;
  String? country;
  String? phoneNo;
  String? dob;

  UserProfileData(
      {this.id,
      this.name,
      this.email,
      this.stripeCustomerId,
      this.defaultPaymentMethod,
      this.emailVerifiedAt,
      this.age,
      this.createdAt,
      this.updatedAt,
      this.coupon,
      this.isPremium,
      this.userImg,
      this.role,
      this.deviceToken,
      this.code,
      this.codeGeneratedAt,
      this.verified,
      this.status,
      this.fcmToken,
      this.country,
      this.phoneNo,
      this.dob});

  UserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    stripeCustomerId = json['stripe_customer_id'];
    defaultPaymentMethod = json['default_payment_method'];
    emailVerifiedAt = json['email_verified_at'];
    age = json['age'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    coupon = json['coupon'];
    isPremium = json['is_premium'];
    userImg = json['user_img'];
    role = json['role'];
    deviceToken = json['device_token'];
    code = json['code'];
    codeGeneratedAt = json['code_generated_at'];
    verified = json['verified'];
    status = json['status'];
    fcmToken = json['fcm_token'];
    country = json['country'];
    phoneNo = json['phone_no'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['stripe_customer_id'] = stripeCustomerId;
    data['default_payment_method'] = defaultPaymentMethod;
    data['email_verified_at'] = emailVerifiedAt;
    data['age'] = age;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['coupon'] = coupon;
    data['is_premium'] = isPremium;
    data['user_img'] = userImg;
    data['role'] = role;
    data['device_token'] = deviceToken;
    data['code'] = code;
    data['code_generated_at'] = codeGeneratedAt;
    data['verified'] = verified;
    data['status'] = status;
    data['fcm_token'] = fcmToken;
    data['country'] = country;
    data['phone_no'] = phoneNo;
    data['dob'] = dob;
    return data;
  }
}
