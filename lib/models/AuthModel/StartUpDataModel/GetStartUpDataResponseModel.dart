class GetStartUpDataResponseModel {
  bool? success;
  String? message;
  StartUpData? data;
  int? statusCode;

  GetStartUpDataResponseModel({this.success, this.message, this.data, this.statusCode});

  GetStartUpDataResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new StartUpData.fromJson(json['data']) : null;
    statusCode = json['status code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status code'] = this.statusCode;
    return data;
  }
}

class StartUpData {
  List<Languages>? languages;
  List<Socials>? socials;
  List<Targets>? targets;

  StartUpData({this.languages, this.socials, this.targets});

  StartUpData.fromJson(Map<String, dynamic> json) {
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['socials'] != null) {
      socials = <Socials>[];
      json['socials'].forEach((v) {
        socials!.add(new Socials.fromJson(v));
      });
    }
    if (json['targets'] != null) {
      targets = <Targets>[];
      json['targets'].forEach((v) {
        targets!.add(new Targets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.socials != null) {
      data['socials'] = this.socials!.map((v) => v.toJson()).toList();
    }
    if (this.targets != null) {
      data['targets'] = this.targets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  int? id;
  String? local;
  String? name;
  int? def;
  String? createdAt;
  String? updatedAt;
  String? language;
  String? flagImg;

  Languages({
    this.id,
    this.local,
    this.name,
    this.def,
    this.createdAt,
    this.updatedAt,
    this.language,
    this.flagImg, // Initialize it to false by default.
  });

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    local = json['local'];
    name = json['name'];
    def = json['def'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    language = json['language'];
    flagImg = json['flag_img']; // Set this based on the response if applicable.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['local'] = local;
    data['name'] = name;
    data['def'] = def;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['language'] = language;
    data['flag_img'] = flagImg; // Save selection state.
    return data;
  }
}

class Socials {
  int? id;
  String? source;
  String? icon;
  String? createdAt;
  String? updatedAt;

  Socials({this.id, this.source, this.icon, this.createdAt, this.updatedAt});

  Socials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    source = json['source'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at']; // Set this based on the response if applicable.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['source'] = this.source;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt; // Save selection state.

    return data;
  }
}

class Targets {
  String? target;
  String? state;
  int? id;

  Targets({this.target, this.state, this.id});

  Targets.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    state = json['state'];
    id = json['id']; // Set this based on the response if applicable.
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target'] = this.target;
    data['state'] = this.state;
    data['id'] = this.id; // Save selection state.

    return data;
  }
}
