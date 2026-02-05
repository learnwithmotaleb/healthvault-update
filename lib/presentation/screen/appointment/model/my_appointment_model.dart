class MyAppoinmentModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  MyAppoinmentModel({this.success, this.message, this.statusCode, this.data});

  MyAppoinmentModel.fromJson(Map<String, dynamic> json) {
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
  NormalUserId? normalUserId;
  ProviderId? providerId;
  ServiceId? serviceId;
  String? reasonForVisit;
  String? appointmentDateTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.normalUserId,
        this.providerId,
        this.serviceId,
        this.reasonForVisit,
        this.appointmentDateTime,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    normalUserId = json['normalUserId'] != null
        ? new NormalUserId.fromJson(json['normalUserId'])
        : null;
    providerId = json['providerId'] != null
        ? new ProviderId.fromJson(json['providerId'])
        : null;
    serviceId = json['serviceId'] != null
        ? new ServiceId.fromJson(json['serviceId'])
        : null;
    reasonForVisit = json['reasonForVisit'];
    appointmentDateTime = json['appointmentDateTime'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.normalUserId != null) {
      data['normalUserId'] = this.normalUserId!.toJson();
    }
    if (this.providerId != null) {
      data['providerId'] = this.providerId!.toJson();
    }
    if (this.serviceId != null) {
      data['serviceId'] = this.serviceId!.toJson();
    }
    data['reasonForVisit'] = this.reasonForVisit;
    data['appointmentDateTime'] = this.appointmentDateTime;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class NormalUserId {
  String? sId;
  String? user;
  String? profileImage;
  String? fullName;
  String? dateOfBirth;
  String? gender;
  String? bloodGroup;
  String? membershipId;
  String? address;
  String? emergencyContact;
  String? identificationNumber;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NormalUserId(
      {this.sId,
        this.user,
        this.profileImage,
        this.fullName,
        this.dateOfBirth,
        this.gender,
        this.bloodGroup,
        this.membershipId,
        this.address,
        this.emergencyContact,
        this.identificationNumber,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NormalUserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    profileImage = json['profile_image'];
    fullName = json['fullName'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    bloodGroup = json['bloodGroup'];
    membershipId = json['membershipId'];
    address = json['address'];
    emergencyContact = json['emergencyContact'];
    identificationNumber = json['identificationNumber'];
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
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['bloodGroup'] = this.bloodGroup;
    data['membershipId'] = this.membershipId;
    data['address'] = this.address;
    data['emergencyContact'] = this.emergencyContact;
    data['identificationNumber'] = this.identificationNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ProviderId {
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

  ProviderId(
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

  ProviderId.fromJson(Map<String, dynamic> json) {
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

class ServiceId {
  String? sId;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ServiceId(
      {this.sId,
        this.providerType,
        this.isAdminCreated,
        this.title,
        this.price,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  ServiceId.fromJson(Map<String, dynamic> json) {
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
