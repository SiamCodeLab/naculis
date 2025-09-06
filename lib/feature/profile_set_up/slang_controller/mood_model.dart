class MoodModel {
  final num moodId;
  final String name;
  final String slug;

  MoodModel({required this.moodId, required this.name, required this.slug});

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      moodId: json['mood_id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  MoodModel copyWith({num? moodId, String? name, String? slug}) {
    return MoodModel(
      moodId: moodId ?? this.moodId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toJson() {
    return {'mood_id': moodId, 'name': name, 'slug': slug};
  }
  static List<MoodModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MoodModel.fromJson(json)).toList();
  }
}
