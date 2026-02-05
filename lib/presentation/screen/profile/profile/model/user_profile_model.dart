class UserProfile {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  UserProfile({this.success, this.message, this.statusCode, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? email;
  String? phone;
  String? role;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? profileId;
  String? profileObjectId;
  List<NormalUserDetails>? normalUserDetails;

  Data(
      {this.sId,
        this.fullName,
        this.email,
        this.phone,
        this.role,
        this.isBlocked,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.profileId,
        this.profileObjectId,
        this.normalUserDetails});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    profileId = json['profileId'];
    profileObjectId = json['profileObjectId'];
    if (json['normalUserDetails'] != null) {
      normalUserDetails = <NormalUserDetails>[];
      json['normalUserDetails'].forEach((v) {
        normalUserDetails!.add(new NormalUserDetails.fromJson(v));
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['profileId'] = this.profileId;
    data['profileObjectId'] = this.profileObjectId;
    if (this.normalUserDetails != null) {
      data['normalUserDetails'] =
          this.normalUserDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NormalUserDetails {
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

  NormalUserDetails(
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

  NormalUserDetails.fromJson(Map<String, dynamic> json) {
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
