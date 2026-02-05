class MedicalDocument {
  final List<String> mySelfImages;
  final List<String> familyImages;

  MedicalDocument({
    required this.mySelfImages,
    required this.familyImages,
  });

  factory MedicalDocument.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return MedicalDocument(
      mySelfImages:
      List<String>.from(data['medical_mySelf_image'] ?? []),
      familyImages:
      List<String>.from(data['medical_family_image'] ?? []),
    );
  }
}
