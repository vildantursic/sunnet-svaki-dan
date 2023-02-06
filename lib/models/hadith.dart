class HadithModel {
  String id;
  String category;
  String title;
  String body;
  String carrier;

  HadithModel(this.id, this.category, this.title, this.body, this.carrier);

  factory HadithModel.fromJson(dynamic json) {
    return HadithModel(
      json['id'] as String,
      json['category'] as String,
      json['title'] as String,
      json['body'] as String,
      json['carrier'] as String,
    );
  }
}
