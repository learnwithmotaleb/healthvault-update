class ServiceData {
  String? id;
  String? providerType;
  String? title;
  int? price;

  ServiceData({this.id, this.providerType, this.title, this.price});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json["_id"],
      providerType: json["providerType"],
      title: json["title"],
      price: json["price"],
    );
  }
}
