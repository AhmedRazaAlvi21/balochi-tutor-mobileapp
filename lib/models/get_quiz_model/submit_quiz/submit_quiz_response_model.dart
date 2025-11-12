class SubmitQuizResponseModel {
  bool? success;
  ResultData? data;
  String? type;
  String? message;
  int? code;

  SubmitQuizResponseModel({this.success, this.data, this.type, this.message, this.code});

  SubmitQuizResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? ResultData.fromJson(json['data']) : null;
    type = json['type'];
    type = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['type'] = type;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class ResultData {
  String? score;
  bool? passed;

  ResultData({this.score, this.passed});

  ResultData.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    passed = json['passed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] = score;
    data['passed'] = passed;
    return data;
  }
}
