class PaymentProcessResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  PaymentProcessResponseModel({this.success, this.message, this.data, this.code});

  PaymentProcessResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? userId;
  String? planName;
  String? paymentSource;
  int? price;
  String? currency;
  String? paymentViaScreenshot;
  String? paymentDate;
  String? paymentStatus;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.planName,
      this.paymentSource,
      this.price,
      this.currency,
      this.paymentViaScreenshot,
      this.paymentDate,
      this.paymentStatus,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    planName = json['plan_name'];
    paymentSource = json['payment_source'];
    price = json['price'];
    currency = json['currency'];
    paymentViaScreenshot = json['payment_via_screenshot'];
    paymentDate = json['payment_date'];
    paymentStatus = json['payment_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['plan_name'] = planName;
    data['payment_source'] = paymentSource;
    data['price'] = price;
    data['currency'] = currency;
    data['payment_via_screenshot'] = paymentViaScreenshot;
    data['payment_date'] = paymentDate;
    data['payment_status'] = paymentStatus;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
