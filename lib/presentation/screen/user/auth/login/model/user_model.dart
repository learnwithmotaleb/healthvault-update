class UserModel {
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  UserModel({this.success, this.message, this.statusCode, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  JwtPayload? jwtPayload;

  Data({this.accessToken, this.jwtPayload});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    jwtPayload = json['jwtPayload'] != null
        ? new JwtPayload.fromJson(json['jwtPayload'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.jwtPayload != null) {
      data['jwtPayload'] = this.jwtPayload!.toJson();
    }
    return data;
  }
}

class JwtPayload {
  String? id;
  String? profileId;
  String? email;
  String? role;

  JwtPayload({this.id, this.profileId, this.email, this.role});

  JwtPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profileId'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profileId'] = this.profileId;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
