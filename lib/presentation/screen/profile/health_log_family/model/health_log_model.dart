class HealthLogFamilyModel {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  HealthLogFamilyModel({this.success, this.message, this.statusCode, this.data});

  factory HealthLogFamilyModel.fromJson(Map<String, dynamic> json) {
    return HealthLogFamilyModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      statusCode: json['statusCode'] as int?,
      data: json['data'] != null
          ? List<Data>.from(json['data'].map((x) => Data.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "statusCode": statusCode,
      "data": data?.map((x) => x.toJson()).toList(),
    };
  }
}

class Data {
  String? sId;
  String? normalUserId;
  String? forWhom;
  String? familyMemberName;
  String? bloodPressure;
  String? heartRate;
  double? weight;
  String? bloodSugar;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({
    this.sId,
    this.normalUserId,
    this.forWhom,
    this.familyMemberName,
    this.bloodPressure,
    this.heartRate,
    this.weight,
    this.bloodSugar,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    // Safe conversion for weight (int, double, or string)
    double parseWeight(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value.toDouble();
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0;
      return 0;
    }

    return Data(
      sId: json['_id'] as String?,
      normalUserId: json['normalUserId'] as String?,
      forWhom: json['forWhom'] as String?,
      familyMemberName: json['familyMemberName'] as String?,
      bloodPressure: json['bloodPressure'] as String?,
      heartRate: json['heartRate'] as String?,
      weight: parseWeight(json['weight']),
      bloodSugar: json['bloodSugar'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": sId,
      "normalUserId": normalUserId,
      "forWhom": forWhom,
      "familyMemberName": familyMemberName,
      "bloodPressure": bloodPressure,
      "heartRate": heartRate,
      "weight": weight,
      "bloodSugar": bloodSugar,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": iV,
    };
  }
}
