class TermsAndConditionModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  TermsAndConditionModel(
      {this.success, this.message, this.statusCode, this.data});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Data(
      {this.sId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
    return data;
  }
}
