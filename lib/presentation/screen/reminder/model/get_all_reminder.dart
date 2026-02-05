class GetReminderAll {
  bool? success;
  String? message;
  int? statusCode;
  List<Data>? data;

  GetReminderAll({this.success, this.message, this.statusCode, this.data});

  GetReminderAll.fromJson(Map<String, dynamic> json) {
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
  ScheduleMeta? scheduleMeta;
  String? sId;
  String? normalUserId;
  String? pillName;
  int? dosage;
  int? timesPerDay;
  String? schedule;
  List<String>? times;
  String? startDate;
  String? endDate;
  String? instructions;
  String? assignedTo;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.scheduleMeta,
        this.sId,
        this.normalUserId,
        this.pillName,
        this.dosage,
        this.timesPerDay,
        this.schedule,
        this.times,
        this.startDate,
        this.endDate,
        this.instructions,
        this.assignedTo,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    scheduleMeta = json['scheduleMeta'] != null
        ? new ScheduleMeta.fromJson(json['scheduleMeta'])
        : null;
    sId = json['_id'];
    normalUserId = json['normalUserId'];
    pillName = json['pillName'];
    dosage = json['dosage'];
    timesPerDay = json['timesPerDay'];
    schedule = json['schedule'];
    times = json['times'].cast<String>();
    startDate = json['startDate'];
    endDate = json['endDate'];
    instructions = json['instructions'];
    assignedTo = json['assignedTo'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.scheduleMeta != null) {
      data['scheduleMeta'] = this.scheduleMeta!.toJson();
    }
    data['_id'] = this.sId;
    data['normalUserId'] = this.normalUserId;
    data['pillName'] = this.pillName;
    data['dosage'] = this.dosage;
    data['timesPerDay'] = this.timesPerDay;
    data['schedule'] = this.schedule;
    data['times'] = this.times;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['instructions'] = this.instructions;
    data['assignedTo'] = this.assignedTo;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ScheduleMeta {
  int? dayOfWeek;

  ScheduleMeta({this.dayOfWeek});

  ScheduleMeta.fromJson(Map<String, dynamic> json) {
    dayOfWeek = json['dayOfWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayOfWeek'] = this.dayOfWeek;
    return data;
  }
}
