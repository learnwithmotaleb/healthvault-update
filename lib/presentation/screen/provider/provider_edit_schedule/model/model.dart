class AvailabilityDayModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  AvailabilityDayModel(
      {this.success, this.message, this.statusCode, this.data});

  AvailabilityDayModel.fromJson(Map<String, dynamic> json) {
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
  String? dayOfWeek;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<ProviderDetails>? providerDetails;
  List<AvailabilitySlots>? availabilitySlots;

  Data(
      {this.sId,
        this.providerId,
        this.dayOfWeek,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.providerDetails,
        this.availabilitySlots});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    providerId = json['providerId'];
    dayOfWeek = json['dayOfWeek'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['providerDetails'] != null) {
      providerDetails = <ProviderDetails>[];
      json['providerDetails'].forEach((v) {
        providerDetails!.add(new ProviderDetails.fromJson(v));
      });
    }
    if (json['availabilitySlots'] != null) {
      availabilitySlots = <AvailabilitySlots>[];
      json['availabilitySlots'].forEach((v) {
        availabilitySlots!.add(new AvailabilitySlots.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['providerId'] = this.providerId;
    data['dayOfWeek'] = this.dayOfWeek;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.providerDetails != null) {
      data['providerDetails'] =
          this.providerDetails!.map((v) => v.toJson()).toList();
    }
    if (this.availabilitySlots != null) {
      data['availabilitySlots'] =
          this.availabilitySlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderDetails {
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

  ProviderDetails(
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

  ProviderDetails.fromJson(Map<String, dynamic> json) {
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

class AvailabilitySlots {
  String? sId;
  String? availabilityDayId;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AvailabilitySlots(
      {this.sId,
        this.availabilityDayId,
        this.startTime,
        this.endTime,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AvailabilitySlots.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    availabilityDayId = json['availabilityDayId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['availabilityDayId'] = this.availabilityDayId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
