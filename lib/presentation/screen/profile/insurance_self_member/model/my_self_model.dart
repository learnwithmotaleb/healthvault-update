class InsuranceSelfModel {
  bool? success;
  String? message;
  int? statusCode;
  List<InsuranceData>? data;

  InsuranceSelfModel({this.success, this.message, this.statusCode, this.data});

  factory InsuranceSelfModel.fromJson(Map<String, dynamic> json) {
    return InsuranceSelfModel(
      success: json['success'],
      message: json['message'],
      statusCode: json['statusCode'],
      data: json['data'] != null
          ? (json['data'] as List)
          .map((e) => InsuranceData.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'statusCode': statusCode,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class InsuranceData {
  String? sId;
  String? normalUserId;
  String? forWhom;
  String? name;
  String? number;
  String? insuranceProvider;
  String? insurancePhoto; // <-- added
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  InsuranceData({
    this.sId,
    this.normalUserId,
    this.forWhom,
    this.name,
    this.number,
    this.insuranceProvider,
    this.insurancePhoto,
    this.expiryDate,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory InsuranceData.fromJson(Map<String, dynamic> json) {
    return InsuranceData(
      sId: json['_id'],
      normalUserId: json['normalUserId'],
      forWhom: json['forWhom'],
      name: json['name'],
      number: json['number'],
      insuranceProvider: json['insuranceProvider'],
      insurancePhoto: json['insurance_Photo'], // <-- map snake_case
      expiryDate: json['expiryDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': sId,
    'normalUserId': normalUserId,
    'forWhom': forWhom,
    'name': name,
    'number': number,
    'insuranceProvider': insuranceProvider,
    'insurance_Photo': insurancePhoto,
    'expiryDate': expiryDate,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': iV,
  };
}
