class HadithModel {
  String category;
  String title;
  String body;
  String carrier;

  HadithModel(this.category, this.title, this.body, this.carrier);

  factory HadithModel.fromJson(dynamic json) {
    return HadithModel(json['category'] as String, json['title'] as String,
        json['body'] as String, json['carrier'] as String);
  }
}
