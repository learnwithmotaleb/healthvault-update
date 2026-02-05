class MyServicesModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  MyServicesModel({this.success, this.message, this.statusCode, this.data});

  MyServicesModel.fromJson(Map<String, dynamic> json) {
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
  String? providerId;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isDeleted;

  Data(
      {this.sId,
        this.providerId,
        this.providerType,
        this.isAdminCreated,
        this.title,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    providerId = json['providerId'];
    providerType = json['providerType'];
    isAdminCreated = json['isAdminCreated'];
    title = json['title'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['providerId'] = this.providerId;
    data['providerType'] = this.providerType;
    data['isAdminCreated'] = this.isAdminCreated;
    data['title'] = this.title;
    data['price'] = this.price;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}