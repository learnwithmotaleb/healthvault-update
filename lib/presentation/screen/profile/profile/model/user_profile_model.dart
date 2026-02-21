// lib/presentation/screen/profile/model/profile_model.dart

class LoginResponseModel {
  bool? success;
  String? message;
  int? statusCode;
  LoginData? data;

  LoginResponseModel({this.success, this.message, this.statusCode, this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }
}

// ─────────────────────────────────────────────
class LoginData {
  String? accessToken;
  JwtPayload? jwtPayload;
  ProfileData? profileData;

  LoginData({this.accessToken, this.jwtPayload, this.profileData});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      accessToken: json['accessToken'],
      jwtPayload: json['jwtPayload'] != null
          ? JwtPayload.fromJson(json['jwtPayload'])
          : null,
      profileData: json['profileData'] != null
          ? ProfileData.fromJson(json['profileData'])
          : null,
    );
  }
}

// ─────────────────────────────────────────────
class JwtPayload {
  String? id;
  String? profileId;
  String? email;
  String? role; // "PROVIDER" or "NORMALUSER"

  JwtPayload({this.id, this.profileId, this.email, this.role});

  factory JwtPayload.fromJson(Map<String, dynamic> json) {
    return JwtPayload(
      id: json['id'],
      profileId: json['profileId'],
      email: json['email'],
      role: json['role'],
    );
  }

  // ✅ Helper getters
  bool get isProvider => role == 'PROVIDER';
  bool get isNormalUser => role == 'NORMALUSER';
}

// ─────────────────────────────────────────────
class ProfileData {
  String? sId;
  String? user;
  String? profileImage;           // ✅ both
  String? fullName;               // ✅ both
  String? dateOfBirth;            // ✅ user only
  String? gender;                 // ✅ user only
  String? bloodGroup;             // ✅ user only
  String? membershipId;           // ✅ user only
  String? address;                // ✅ both
  String? emergencyContact;       // ✅ user only
  String? identificationNumber;   // ✅ both

  // ✅ Provider only fields
  ProviderTypeId? providerTypeId;
  List<ServiceItem>? serviceId;
  String? about;
  String? specialization;
  String? medicalLicenseNumber;
  int? yearsOfExperience;
  List<String>? languages;
  bool? isVerified;
  bool? isActive;

  String? createdAt;
  String? updatedAt;

  ProfileData({
    this.sId,
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
    this.providerTypeId,
    this.serviceId,
    this.about,
    this.specialization,
    this.medicalLicenseNumber,
    this.yearsOfExperience,
    this.languages,
    this.isVerified,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      sId: json['_id'],
      user: json['user'],
      profileImage: json['profile_image'],
      fullName: json['fullName'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      bloodGroup: json['bloodGroup'],
      membershipId: json['membershipId'],
      address: json['address'],
      emergencyContact: json['emergencyContact'],
      identificationNumber: json['identificationNumber'],

      // ✅ Provider only — safely null for normal users
      providerTypeId: json['providerTypeId'] != null
          ? ProviderTypeId.fromJson(json['providerTypeId'])
          : null,
      serviceId: json['serviceId'] != null
          ? List<ServiceItem>.from(
          json['serviceId'].map((x) => ServiceItem.fromJson(x)))
          : null,
      about: json['about'],
      specialization: json['specialization'],
      medicalLicenseNumber: json['medicalLicenseNumber'],
      yearsOfExperience: json['yearsOfExperience'],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
      isVerified: json['isVerified'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

// ─────────────────────────────────────────────
class ProviderTypeId {
  String? sId;
  String? key;
  String? label;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  ProviderTypeId({
    this.sId,
    this.key,
    this.label,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory ProviderTypeId.fromJson(Map<String, dynamic> json) {
    return ProviderTypeId(
      sId: json['_id'],
      key: json['key'],
      label: json['label'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

// ─────────────────────────────────────────────
class ServiceItem {
  String? sId;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;

  ServiceItem({
    this.sId,
    this.providerType,
    this.isAdminCreated,
    this.title,
    this.price,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      sId: json['_id'],
      providerType: json['providerType'],
      isAdminCreated: json['isAdminCreated'],
      title: json['title'],
      price: json['price'],
      isDeleted: json['isDeleted'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}