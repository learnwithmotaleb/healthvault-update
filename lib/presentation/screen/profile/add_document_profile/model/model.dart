class ImageModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  ImageModel({this.success, this.message, this.statusCode, this.data});

  ImageModel.fromJson(Map<String, dynamic> json) {
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
  String? normalUserId;
  List<String>? medicalMySelfImage;
  List<String>? medicalFamilyImage;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.normalUserId,
        this.medicalMySelfImage,
        this.medicalFamilyImage,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    normalUserId = json['normalUserId'];
    medicalMySelfImage = json['medical_mySelf_image'].cast<String>();
    medicalFamilyImage = json['medical_family_image'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['normalUserId'] = this.normalUserId;
    data['medical_mySelf_image'] = this.medicalMySelfImage;
    data['medical_family_image'] = this.medicalFamilyImage;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
