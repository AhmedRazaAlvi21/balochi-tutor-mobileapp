class GetDashboardDataResponseModel {
  bool? success;
  String? message;
  int? code;
  DashboardData? data;

  GetDashboardDataResponseModel({this.success, this.message, this.code, this.data});

  GetDashboardDataResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardData {
  User? user;
  Course? course;
  Updates? updates;
  RecentlyDone? recentlyDone;

  DashboardData({this.user, this.course, this.updates, this.recentlyDone});

  DashboardData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    updates = json['updates'] != null ? Updates.fromJson(json['updates']) : null;
    recentlyDone = json['recently_done'] != null ? RecentlyDone.fromJson(json['recently_done']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (course != null) {
      data['course'] = course!.toJson();
    }
    if (updates != null) {
      data['updates'] = updates!.toJson();
    }
    if (recentlyDone != null) {
      data['recently_done'] = recentlyDone!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  int? stripeCustomerId;
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
  String? code;
  String? codeGeneratedAt;
  int? verified;
  int? status;
  String? fcmToken;
  String? country;
  String? phoneNo;
  String? dob;
  String? userCourseProgress;

  User(
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
      this.dob,
      this.userCourseProgress});

  User.fromJson(Map<String, dynamic> json) {
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
    userCourseProgress = json['user_course_progress'];
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
    data['code'] = code;
    data['code_generated_at'] = codeGeneratedAt;
    data['verified'] = verified;
    data['status'] = status;
    data['fcm_token'] = fcmToken;
    data['country'] = country;
    data['phone_no'] = phoneNo;
    data['dob'] = dob;
    data['user_course_progress'] = userCourseProgress;
    return data;
  }
}

class Course {
  int? id;
  String? userId;
  String? title;
  String? shortDetail;
  String? detail;
  String? requirement;
  String? video;
  String? url;
  String? featured;
  String? slug;
  String? status;
  String? previewImage;
  String? videoUrl;
  String? previewType;
  String? label;
  String? type;
  String? createdAt;
  String? updatedAt;

  Course(
      {this.id,
      this.userId,
      this.title,
      this.shortDetail,
      this.detail,
      this.requirement,
      this.video,
      this.url,
      this.featured,
      this.slug,
      this.status,
      this.previewImage,
      this.videoUrl,
      this.previewType,
      this.label,
      this.type,
      this.createdAt,
      this.updatedAt});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    shortDetail = json['short_detail'];
    detail = json['detail'];
    requirement = json['requirement'];
    video = json['video'];
    url = json['url'];
    featured = json['featured'];
    slug = json['slug'];
    status = json['status'];
    previewImage = json['preview_image'];
    videoUrl = json['video_url'];
    previewType = json['preview_type'];
    label = json['label'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['short_detail'] = shortDetail;
    data['detail'] = detail;
    data['requirement'] = requirement;
    data['video'] = video;
    data['url'] = url;
    data['featured'] = featured;
    data['slug'] = slug;
    data['status'] = status;
    data['preview_image'] = previewImage;
    data['video_url'] = videoUrl;
    data['preview_type'] = previewType;
    data['label'] = label;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Updates {
  int? currentDay;
  int? lessonsPassed;
  int? correctPractices;
  int? quizPassed;

  Updates({this.currentDay, this.lessonsPassed, this.correctPractices, this.quizPassed});

  Updates.fromJson(Map<String, dynamic> json) {
    currentDay = json['current_day'];
    lessonsPassed = json['lessons_passed'];
    correctPractices = json['correct_practices'];
    quizPassed = json['quiz_passed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_day'] = currentDay;
    data['lessons_passed'] = lessonsPassed;
    data['correct_practices'] = correctPractices;
    data['quiz_passed'] = quizPassed;
    return data;
  }
}

class RecentlyDone {
  int? id;
  int? courseId;
  int? dayNumber;
  String? title;
  String? description;
  String? status;
  int? order;
  String? image;
  String? video;
  String? audio;
  String? createdAt;
  String? updatedAt;

  RecentlyDone(
      {this.id,
      this.courseId,
      this.dayNumber,
      this.title,
      this.description,
      this.status,
      this.order,
      this.image,
      this.video,
      this.audio,
      this.createdAt,
      this.updatedAt});

  RecentlyDone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    dayNumber = json['day_number'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    order = json['order'];
    image = json['image'];
    video = json['video'];
    audio = json['audio'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['day_number'] = dayNumber;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['order'] = order;
    data['image'] = image;
    data['video'] = video;
    data['audio'] = audio;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
