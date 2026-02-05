// =====================
// Provider Type Response
// =====================
class ProviderTypeModel {
  final bool success;
  final String message;
  final int statusCode;
  final List<ProviderType> data;

  ProviderTypeModel({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory ProviderTypeModel.fromJson(Map<String, dynamic> json) {
    return ProviderTypeModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] != null
          ? List<ProviderType>.from(
        json['data'].map(
              (x) => ProviderType.fromJson(x),
        ),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'statusCode': statusCode,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}
// =====================
// Provider Type Item
// =====================
class ProviderType {
  final String id;
  final String key;
  final String label;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  ProviderType({
    required this.id,
    required this.key,
    required this.label,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ProviderType.fromJson(Map<String, dynamic> json) {
    return ProviderType(
      id: json['_id'] ?? '',
      key: json['key'] ?? '',
      label: json['label'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'key': key,
      'label': label,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
    };
  }
}
