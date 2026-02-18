class ImageModel {
  final bool? success;
  final String? message;
  final int? statusCode;
  final ImageData? data;

  ImageModel({
    this.success,
    this.message,
    this.statusCode,
    this.data,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    success: json['success'],
    message: json['message'],
    statusCode: json['statusCode'],
    data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'statusCode': statusCode,
    'data': data?.toJson(),
  };
}

class ImageData {
  final String? id;
  final String? normalUserId;
  final List<String>? medicalMySelfImage;
  final List<String>? medicalFamilyImage;
  final String? updatedAt;

  ImageData({
    this.id,
    this.normalUserId,
    this.medicalMySelfImage,
    this.medicalFamilyImage,
    this.updatedAt,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
    id: json['_id'],
    normalUserId: json['normalUserId'],
    medicalMySelfImage: json['medical_mySelf_image'] != null
        ? List<String>.from(json['medical_mySelf_image'])
        : [],
    medicalFamilyImage: json['medical_family_image'] != null
        ? List<String>.from(json['medical_family_image'])
        : [],
    updatedAt: json['updatedAt'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'normalUserId': normalUserId,
    'medical_mySelf_image': medicalMySelfImage,
    'medical_family_image': medicalFamilyImage,
    'updatedAt': updatedAt,
  };
}