class ProviderAppointmentModel {
  bool? success;
  String? message;
  int? statusCode;
  AppointmentData? data;

  ProviderAppointmentModel({this.success, this.message, this.statusCode, this.data});

  factory ProviderAppointmentModel.fromJson(Map<String, dynamic> json) {
    return ProviderAppointmentModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      data: json['data'] != null ? AppointmentData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'statusCode': statusCode,
    'data': data?.toJson(),
  };
}

class AppointmentData {
  Meta? meta;
  List<Appointment>? data;

  AppointmentData({this.meta, this.data});

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<Appointment>.from(json['data'].map((x) => Appointment.fromJson(x)))
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

class Appointment {
  String? sId;
  NormalUser? normalUserId;
  Provider? providerId;
  Service? serviceId;
  String? reasonForVisit;
  String? appointmentDateTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? appointmentImages;

  Appointment({
    this.sId,
    this.normalUserId,
    this.providerId,
    this.serviceId,
    this.reasonForVisit,
    this.appointmentDateTime,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.appointmentImages,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    sId: json['_id'],
    normalUserId:
    json['normalUserId'] != null ? NormalUser.fromJson(json['normalUserId']) : null,
    providerId:
    json['providerId'] != null ? Provider.fromJson(json['providerId']) : null,
    serviceId: json['serviceId'] != null ? Service.fromJson(json['serviceId']) : null,
    reasonForVisit: json['reasonForVisit'],
    appointmentDateTime: json['appointmentDateTime'],
    status: json['status'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
    iV: json['__v'],
    appointmentImages: json['appointment_images'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'normalUserId': normalUserId?.toJson(),
    'providerId': providerId?.toJson(),
    'serviceId': serviceId?.toJson(),
    'reasonForVisit': reasonForVisit,
    'appointmentDateTime': appointmentDateTime,
    'status': status,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
    'appointment_images': appointmentImages,
  };
}

class NormalUser {
  String? sId;
  String? profileImage;
  String? fullName;

  NormalUser({this.sId, this.profileImage, this.fullName});

  factory NormalUser.fromJson(Map<String, dynamic> json) => NormalUser(
    sId: json['_id'],
    profileImage: json['profile_image'],
    fullName: json['fullName'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'profile_image': profileImage,
    'fullName': fullName,
  };
}

class Provider {
  String? sId;
  String? address;

  Provider({this.sId, this.address});

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    sId: json['_id'],
    address: json['address'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'address': address,
  };
}

class Service {
  String? sId;
  String? title;
  int? price;

  Service({this.sId, this.title, this.price});

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    sId: json['_id'],
    title: json['title'],
    price: json['price'],
  );

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'title': title,
    'price': price,
  };
}
