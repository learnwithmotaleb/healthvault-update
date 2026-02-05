class ServiceCreatedModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  ServiceCreatedModel({this.success, this.message, this.statusCode, this.data});

  ServiceCreatedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.providerType,
        this.isAdminCreated,
        this.title,
        this.price,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    providerType = json['providerType'];
    isAdminCreated = json['isAdminCreated'];
    title = json['title'];
    price = json['price'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['providerType'] = this.providerType;
    data['isAdminCreated'] = this.isAdminCreated;
    data['title'] = this.title;
    data['price'] = this.price;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
