class UpdateNotificationResponse {
  bool? success;
  String? message;
  UpdateNotificationData? data;
  int? code;

  UpdateNotificationResponse({this.success, this.message, this.data, this.code});

  UpdateNotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UpdateNotificationData.fromJson(json['data']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = code;
    return data;
  }
}

class UpdateNotificationData {
  int? id;
  String? name;
  String? email;
  String? stripeCustomerId;
  String? defaultPaymentMethod;
  String? emailVerifiedAt;
  int? age;
  String? createdAt;
  String? updatedAt;
  String? coupon;
  int? isPremium;
  String? userImg;
  String? role;
  String? deviceToken;
  bool? allowNotifications;
  String? code;
  String? codeGeneratedAt;
  int? verified;
  int? status;
  String? fcmToken;
  String? country;
  String? phoneNo;
  String? dob;

  UpdateNotificationData(
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
      this.allowNotifications,
      this.code,
      this.codeGeneratedAt,
      this.verified,
      this.status,
      this.fcmToken,
      this.country,
      this.phoneNo,
      this.dob});

  UpdateNotificationData.fromJson(Map<String, dynamic> json) {
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
    allowNotifications = json['allow_notifications'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['allow_notifications'] = allowNotifications;
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
