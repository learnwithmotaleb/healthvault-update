class ProviderProfileModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  ProviderProfileModel(
      {this.success, this.message, this.statusCode, this.data});

  ProviderProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? email;
  String? phone;
  String? role;
  bool? isBlocked;
  bool? isResetOTPVerified;
  bool? isVerifyEmailOTPVerified;
  String? passwordChangedAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profileId;
  String? profileObjectId;
  Provider? provider;
  ProviderType? providerType;
  List<Services>? services;

  Data(
      {this.sId,
        this.fullName,
        this.email,
        this.phone,
        this.role,
        this.isBlocked,
        this.isResetOTPVerified,
        this.isVerifyEmailOTPVerified,
        this.passwordChangedAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.profileId,
        this.profileObjectId,
        this.provider,
        this.providerType,
        this.services});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    isResetOTPVerified = json['isResetOTPVerified'];
    isVerifyEmailOTPVerified = json['isVerifyEmailOTPVerified'];
    passwordChangedAt = json['passwordChangedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profileId = json['profileId'];
    profileObjectId = json['profileObjectId'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    providerType = json['providerType'] != null
        ? new ProviderType.fromJson(json['providerType'])
        : null;
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['isBlocked'] = this.isBlocked;
    data['isResetOTPVerified'] = this.isResetOTPVerified;
    data['isVerifyEmailOTPVerified'] = this.isVerifyEmailOTPVerified;
    data['passwordChangedAt'] = this.passwordChangedAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['profileId'] = this.profileId;
    data['profileObjectId'] = this.profileObjectId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.providerType != null) {
      data['providerType'] = this.providerType!.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provider {
  String? sId;
  String? user;
  String? profileImage;
  String? fullName;
  String? providerTypeId;
  List<String>? serviceId;
  String? about;
  String? address;
  String? identificationNumber;
  String? identificationImages;
  String? specialization;
  String? medicalLicenseNumber;
  int? yearsOfExperience;
  List<String>? languages;
  bool? isVerified;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Provider(
      {this.sId,
        this.user,
        this.profileImage,
        this.fullName,
        this.providerTypeId,
        this.serviceId,
        this.about,
        this.address,
        this.identificationNumber,
        this.identificationImages,
        this.specialization,
        this.medicalLicenseNumber,
        this.yearsOfExperience,
        this.languages,
        this.isVerified,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Provider.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    profileImage = json['profile_image'];
    fullName = json['fullName'];
    providerTypeId = json['providerTypeId'];
    serviceId = json['serviceId'].cast<String>();
    about = json['about'];
    address = json['address'];
    identificationNumber = json['identificationNumber'];
    identificationImages = json['identification_images'];
    specialization = json['specialization'];
    medicalLicenseNumber = json['medicalLicenseNumber'];
    yearsOfExperience = json['yearsOfExperience'];
    languages = json['languages'].cast<String>();
    isVerified = json['isVerified'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['profile_image'] = this.profileImage;
    data['fullName'] = this.fullName;
    data['providerTypeId'] = this.providerTypeId;
    data['serviceId'] = this.serviceId;
    data['about'] = this.about;
    data['address'] = this.address;
    data['identificationNumber'] = this.identificationNumber;
    data['identification_images'] = this.identificationImages;
    data['specialization'] = this.specialization;
    data['medicalLicenseNumber'] = this.medicalLicenseNumber;
    data['yearsOfExperience'] = this.yearsOfExperience;
    data['languages'] = this.languages;
    data['isVerified'] = this.isVerified;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProviderType {
  String? sId;
  String? key;
  String? label;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProviderType(
      {this.sId,
        this.key,
        this.label,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ProviderType.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    key = json['key'];
    label = json['label'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['key'] = this.key;
    data['label'] = this.label;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Services {
  String? title;
  int? price;

  Services({this.title, this.price});

  Services.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}
