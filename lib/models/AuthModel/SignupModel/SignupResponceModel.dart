class SignupResponseModel {
  bool? success;
  String? message;
  int? code;
  String? error;
  Map<String, dynamic>? validationMessage;

  SignupResponseModel({
    this.success,
    this.message,
    this.code,
    this.error,
    this.validationMessage,
  });

  SignupResponseModel.fromJson(Map<String, dynamic> json) {
    // For success case
    success = json['success'];
    code = json['code'];

    // For error case or normal message
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is Map<String, dynamic>) {
      validationMessage = Map<String, dynamic>.from(json['message']);
    }

    // Error field (e.g. "Validation Error")
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message ?? validationMessage;
    data['code'] = code;
    data['error'] = error;
    return data;
  }

  /// Helper method to extract readable error (optional)
  String? getFirstValidationError() {
    if (validationMessage == null) return null;
    if (validationMessage!.isNotEmpty) {
      final firstKey = validationMessage!.keys.first;
      final errors = validationMessage![firstKey];
      if (errors is List && errors.isNotEmpty) {
        return errors.first;
      }
    }
    return null;
  }
}
