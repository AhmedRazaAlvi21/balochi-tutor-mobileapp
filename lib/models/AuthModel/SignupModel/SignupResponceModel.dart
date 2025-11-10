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
    success = json['success'];
    code = json['code'];
    error = json['error'];

    // ✅ Handle both normal messages and validation maps
    if (json['message'] is String) {
      message = json['message'];
    } else if (json['message'] is Map<String, dynamic>) {
      validationMessage = Map<String, dynamic>.from(json['message']);
      message = _extractFirstValidationMessage(validationMessage);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message ?? validationMessage;
    data['code'] = code;
    data['error'] = error;
    return data;
  }

  /// ✅ Extracts a readable validation message
  String? _extractFirstValidationMessage(Map<String, dynamic>? validation) {
    if (validation == null || validation.isEmpty) return null;
    final firstKey = validation.keys.first;
    final firstValue = validation[firstKey];
    if (firstValue is List && firstValue.isNotEmpty) {
      return firstValue.first.toString();
    }
    return firstValue.toString();
  }

  /// ✅ Public helper to get clean message
  String? getErrorMessage() {
    return message ?? getFirstValidationError() ?? error ?? "Unknown error occurred";
  }

  /// ✅ Returns first validation error (optional)
  String? getFirstValidationError() {
    if (validationMessage == null || validationMessage!.isEmpty) return null;
    final firstKey = validationMessage!.keys.first;
    final firstValue = validationMessage![firstKey];
    if (firstValue is List && firstValue.isNotEmpty) {
      return firstValue.first.toString();
    }
    return firstValue.toString();
  }
}
