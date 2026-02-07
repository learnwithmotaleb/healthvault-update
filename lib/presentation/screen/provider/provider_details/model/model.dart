class AppointmentDetailsModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  AppointmentDetailsModel(
      {this.success, this.message, this.statusCode, this.data});

  AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
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
  NormalUserId? normalUserId;
  ProviderId? providerId;
  ServiceId? serviceId;
  String? reasonForVisit;
  String? appointmentDateTime;
  String? appointmentImages;
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
        this.appointmentImages,
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
    appointmentImages = json['appointment_images'];
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
    data['appointment_images'] = this.appointmentImages;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class NormalUserId {
  String? sId;
  String? profileImage;
  String? fullName;

  NormalUserId({this.sId, this.profileImage, this.fullName});

  NormalUserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profile_image'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profile_image'] = this.profileImage;
    data['fullName'] = this.fullName;
    return data;
  }
}

class ProviderId {
  String? sId;
  String? address;

  ProviderId({this.sId, this.address});

  ProviderId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address'] = this.address;
    return data;
  }
}

class ServiceId {
  String? sId;
  String? title;
  int? price;

  ServiceId({this.sId, this.title, this.price});

  ServiceId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}
