class GetAllProvidersModel {
  bool? success;
  String? message;
  int? statusCode;
  ProvidersData? data;

  GetAllProvidersModel({this.success, this.message, this.statusCode, this.data});

  factory GetAllProvidersModel.fromJson(Map<String, dynamic> json) {
    return GetAllProvidersModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      data: json['data'] != null ? ProvidersData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'statusCode': statusCode,
    'data': data?.toJson(),
  };
}

class ProvidersData {
  Meta? meta;
  List<Provider>? data;

  ProvidersData({this.meta, this.data});

  factory ProvidersData.fromJson(Map<String, dynamic> json) {
    return ProvidersData(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<Provider>.from(json['data'].map((x) => Provider.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((x) => x.toJson()).toList(),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'total': total,
    'totalPage': totalPage,
  };
}

class Provider {
  String? id;
  List<User>? user;
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
  int? v;
  ProviderType? providerType;
  List<Service>? services;
  List<AvailabilityDay>? availabilityDays;

  Provider({
    this.id,
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
    this.v,
    this.providerType,
    this.services,
    this.availabilityDays,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    id: json['_id'],
    user: json['user'] != null
        ? List<User>.from(json['user'].map((x) => User.fromJson(x)))
        : [],
    profileImage: json['profile_image'],
    fullName: json['fullName'],
    providerTypeId: json['providerTypeId'],
    serviceId: json['serviceId'] != null ? List<String>.from(json['serviceId']) : [],
    about: json['about'],
    address: json['address'],
    identificationNumber: json['identificationNumber'],
    identificationImages: json['identification_images'],
    specialization: json['specialization'],
    medicalLicenseNumber: json['medicalLicenseNumber'],
    yearsOfExperience: json['yearsOfExperience'],
    languages: json['languages'] != null ? List<String>.from(json['languages']) : [],
    isVerified: json['isVerified'],
    isActive: json['isActive'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
    providerType: json['providerType'] != null ? ProviderType.fromJson(json['providerType']) : null,
    services: json['services'] != null
        ? List<Service>.from(json['services'].map((x) => Service.fromJson(x)))
        : [],
    availabilityDays: json['availabilityDays'] != null
        ? List<AvailabilityDay>.from(json['availabilityDays'].map((x) => AvailabilityDay.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'user': user?.map((x) => x.toJson()).toList(),
    'profile_image': profileImage,
    'fullName': fullName,
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
    '__v': v,
    'providerType': providerType?.toJson(),
    'services': services?.map((x) => x.toJson()).toList(),
    'availabilityDays': availabilityDays?.map((x) => x.toJson()).toList(),
  };
}

class User {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? role;
  bool? isBlocked;
  bool? isVerifyEmailOTPVerified;
  List<dynamic>? playerIds;
  String? passwordChangedAt;
  String? createdAt;
  String? updatedAt;
  String? profileId;

  User({
    this.id,
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
    id: json['_id'],
    fullName: json['fullName'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    isBlocked: json['isBlocked'],
    isVerifyEmailOTPVerified: json['isVerifyEmailOTPVerified'],
    playerIds: json['playerIds'] ?? [],
    passwordChangedAt: json['passwordChangedAt'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    profileId: json['profileId'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
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
  String? id;
  String? key;
  String? label;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? v;

  ProviderType({this.id, this.key, this.label, this.isActive, this.createdAt, this.updatedAt, this.v});

  factory ProviderType.fromJson(Map<String, dynamic> json) => ProviderType(
    id: json['_id'],
    key: json['key'],
    label: json['label'],
    isActive: json['isActive'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'key': key,
    'label': label,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class Service {
  String? id;
  String? providerType;
  bool? isAdminCreated;
  String? title;
  int? price;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? v;

  Service({this.id, this.providerType, this.isAdminCreated, this.title, this.price, this.isDeleted, this.createdAt, this.updatedAt, this.v});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json['_id'],
    providerType: json['providerType'],
    isAdminCreated: json['isAdminCreated'],
    title: json['title'],
    price: json['price'],
    isDeleted: json['isDeleted'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'providerType': providerType,
    'isAdminCreated': isAdminCreated,
    'title': title,
    'price': price,
    'isDeleted': isDeleted,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class AvailabilityDay {
  String? id;
  String? providerId;
  String? dayOfWeek;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<AvailabilitySlot>? availabilitySlots;

  AvailabilityDay({this.id, this.providerId, this.dayOfWeek, this.createdAt, this.updatedAt, this.v, this.availabilitySlots});

  factory AvailabilityDay.fromJson(Map<String, dynamic> json) => AvailabilityDay(
    id: json['_id'],
    providerId: json['providerId'],
    dayOfWeek: json['dayOfWeek'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
    availabilitySlots: json['availabilitySlots'] != null
        ? List<AvailabilitySlot>.from(json['availabilitySlots'].map((x) => AvailabilitySlot.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'providerId': providerId,
    'dayOfWeek': dayOfWeek,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'availabilitySlots': availabilitySlots?.map((x) => x.toJson()).toList(),
  };
}

class AvailabilitySlot {
  String? id;
  String? availabilityDayId;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  int? v;

  AvailabilitySlot({this.id, this.availabilityDayId, this.startTime, this.endTime, this.createdAt, this.updatedAt, this.v});

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) => AvailabilitySlot(
    id: json['_id'],
    availabilityDayId: json['availabilityDayId'],
    startTime: json['startTime'],
    endTime: json['endTime'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'availabilityDayId': availabilityDayId,
    'startTime': startTime,
    'endTime': endTime,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}
