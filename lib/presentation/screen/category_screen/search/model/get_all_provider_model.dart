class AllProviderModel {
  bool? success;
  String? message;
  int? statusCode;
  ProviderData? data;

  AllProviderModel({this.success, this.message, this.statusCode, this.data});

  factory AllProviderModel.fromJson(Map<String, dynamic> json) => AllProviderModel(
    success: json['success'],
    message: json['message'],
    statusCode: json['statusCode'],
    data: json['data'] != null ? ProviderData.fromJson(json['data']) : null,
  );

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'statusCode': statusCode,
    'data': data?.toJson(),
  };
}

class ProviderData {
  Meta? meta;
  List<Data>? data;

  ProviderData({this.meta, this.data});

  factory ProviderData.fromJson(Map<String, dynamic> json) => ProviderData(
    meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    data: json['data'] != null
        ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class Data {
  String? sId;
  List<User>? user;
  String? profileImage;
  String? fullName;
  String? displayName;
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
  ProviderType? providerType;
  List<Services>? services;
  List<AvailabilityDays>? availabilityDays;
  String? drugLicenseNumber;
  String? businessRegistrationNumber;

  Data({
    this.sId,
    this.user,
    this.profileImage,
    this.fullName,
    this.displayName,
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
    this.iV,
    this.providerType,
    this.services,
    this.availabilityDays,
    this.drugLicenseNumber,
    this.businessRegistrationNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sId: json['_id'],
    user: json['user'] != null
        ? List<User>.from(json['user'].map((x) => User.fromJson(x)))
        : null,
    profileImage: json['profile_image'],
    fullName: json['fullName'],
    displayName: json['displayName'],
    providerTypeId: json['providerTypeId'],
    serviceId: json['serviceId'] != null ? List<String>.from(json['serviceId']) : null,
    about: json['about'],
    address: json['address'],
    identificationNumber: json['identificationNumber'],
    identificationImages: json['identification_images'],
    specialization: json['specialization'],
    medicalLicenseNumber: json['medicalLicenseNumber'],
    yearsOfExperience: json['yearsOfExperience'],
    languages: json['languages'] != null ? List<String>.from(json['languages']) : null,
    isVerified: json['isVerified'],
    isActive: json['isActive'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
    providerType:
    json['providerType'] != null ? ProviderType.fromJson(json['providerType']) : null,
    services: json['services'] != null
        ? List<Services>.from(json['services'].map((x) => Services.fromJson(x)))
        : null,
    availabilityDays: json['availabilityDays'] != null
        ? List<AvailabilityDays>.from(
        json['availabilityDays'].map((x) => AvailabilityDays.fromJson(x)))
        : null,
    drugLicenseNumber: json['drugLicenseNumber'],
    businessRegistrationNumber: json['businessRegistrationNumber'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'user': user?.map((x) => x.toJson()).toList(),
    'profile_image': profileImage,
    'fullName': fullName,
    'displayName': displayName,
    'providerTypeId': providerTypeId,
    'serviceId': serviceId,
    'about': about,
    'address': address,
    'identificationNumber': identificationNumber,
    'identification_images': identificationImages,
    'specialization': specialization,
    'medicalLicenseNumber': medicalLicenseNumber,
    'yearsOfExperience': yearsOfExperience,
    'languages': languages,
    'isVerified': isVerified,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
    'providerType': providerType?.toJson(),
    'services': services?.map((x) => x.toJson()).toList(),
    'availabilityDays': availabilityDays?.map((x) => x.toJson()).toList(),
    'drugLicenseNumber': drugLicenseNumber,
    'businessRegistrationNumber': businessRegistrationNumber,
  };
}

class User {
  String? sId;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  bool? isBlocked;
  bool? isVerifyEmailOTPVerified;
  List<String>? playerIds;
  String? passwordChangedAt;
  String? createdAt;
  String? updatedAt;
  String? profileId;

  User({
    this.sId,
    this.fullName,
    this.email,
    this.phone,
    this.role,
    this.isBlocked,
    this.isVerifyEmailOTPVerified,
    this.playerIds,
    this.passwordChangedAt,
    this.createdAt,
    this.updatedAt,
    this.profileId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    sId: json['_id'],
    fullName: json['fullName'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    isBlocked: json['isBlocked'],
    isVerifyEmailOTPVerified: json['isVerifyEmailOTPVerified'],
    playerIds:
    json['playerIds'] != null ? List<String>.from(json['playerIds']) : <String>[],
    passwordChangedAt: json['passwordChangedAt'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    profileId: json['profileId'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'role': role,
    'isBlocked': isBlocked,
    'isVerifyEmailOTPVerified': isVerifyEmailOTPVerified,
    'playerIds': playerIds,
    'passwordChangedAt': passwordChangedAt,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'profileId': profileId,
  };
}

class ProviderType {
  String? sId;
  String? key;
  String? label;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProviderType({
    this.sId,
    this.key,
    this.label,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory ProviderType.fromJson(Map<String, dynamic> json) => ProviderType(
    sId: json['_id'],
    key: json['key'],
    label: json['label'],
    isActive: json['isActive'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'key': key,
    'label': label,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };
}

class Services {
  String? sId;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Services({
    this.sId,
    this.providerType,
    this.isAdminCreated,
    this.title,
    this.price,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Services.fromJson(Map<String, dynamic> json) => Services(
    sId: json['_id'],
    providerType: json['providerType'],
    isAdminCreated: json['isAdminCreated'],
    title: json['title'],
    price: json['price'],
    isDeleted: json['isDeleted'] ?? false,
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'providerType': providerType,
    'isAdminCreated': isAdminCreated,
    'title': title,
    'price': price,
    'isDeleted': isDeleted,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };
}

class AvailabilityDays {
  String? sId;
  String? providerId;
  String? dayOfWeek;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<AvailabilitySlots>? availabilitySlots;

  AvailabilityDays({
    this.sId,
    this.providerId,
    this.dayOfWeek,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.availabilitySlots,
  });

  factory AvailabilityDays.fromJson(Map<String, dynamic> json) => AvailabilityDays(
    sId: json['_id'],
    providerId: json['providerId'],
    dayOfWeek: json['dayOfWeek'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
    availabilitySlots: json['availabilitySlots'] != null
        ? List<AvailabilitySlots>.from(
        json['availabilitySlots'].map((x) => AvailabilitySlots.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'providerId': providerId,
    'dayOfWeek': dayOfWeek,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
    'availabilitySlots': availabilitySlots?.map((x) => x.toJson()).toList(),
  };
}

class AvailabilitySlots {
  String? sId;
  String? availabilityDayId;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AvailabilitySlots({
    this.sId,
    this.availabilityDayId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory AvailabilitySlots.fromJson(Map<String, dynamic> json) => AvailabilitySlots(
    sId: json['_id'],
    availabilityDayId: json['availabilityDayId'],
    startTime: json['startTime'],
    endTime: json['endTime'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'availabilityDayId': availabilityDayId,
    'startTime': startTime,
    'endTime': endTime,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json['page'],
    limit: json['limit'],
    total: json['total'],
    totalPage: json['totalPage'],
  );

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
  };
}
