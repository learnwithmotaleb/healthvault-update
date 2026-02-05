class InfoProviderModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  InfoProviderModel({this.success, this.message, this.statusCode, this.data});

  factory InfoProviderModel.fromJson(Map<String, dynamic> json) {
    return InfoProviderModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }
}
class Data {
  String? id;
  User? user;
  String? profileImage;
  String? fullName;
  String? providerTypeId;
  List<String> serviceId;
  String? about;
  String? address;
  String? specialization;
  int? yearsOfExperience;
  List<String> languages;
  bool? isVerified;
  bool? isActive;
  ProviderType? providerType;
  List<Services> services;

  Data({
    this.id,
    this.user,
    this.profileImage,
    this.fullName,
    this.providerTypeId,
    this.serviceId = const [],
    this.about,
    this.address,
    this.specialization,
    this.yearsOfExperience,
    this.languages = const [],
    this.isVerified,
    this.isActive,
    this.providerType,
    this.services = const [],
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      profileImage: json['profile_image'],
      fullName: json['fullName'],
      providerTypeId: json['providerTypeId'],
      serviceId: List<String>.from(json['serviceId'] ?? []),
      about: json['about'],
      address: json['address'],
      specialization: json['specialization'],
      yearsOfExperience: json['yearsOfExperience'],
      languages: List<String>.from(json['languages'] ?? []),
      isVerified: json['isVerified'],
      isActive: json['isActive'],
      providerType: json['providerType'] != null
          ? ProviderType.fromJson(json['providerType'])
          : null,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Services.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;

  User({this.id, this.fullName, this.email, this.phone, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
class ProviderType {
  String? id;
  String? key;
  String? label;

  ProviderType({this.id, this.key, this.label});

  factory ProviderType.fromJson(Map<String, dynamic> json) {
    return ProviderType(
      id: json['_id'],
      key: json['key'],
      label: json['label'],
    );
  }
}
class Services {
  String? id;
  String? title;
  int? price;

  Services({this.id, this.title, this.price});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['_id'],
      title: json['title'],
      price: json['price'],
    );
  }
}

