class SlangModel {
  final int slangId;
  final String name;
  final String slug;

  SlangModel({required this.slangId, required this.name, required this.slug});

  factory SlangModel.fromJson(Map<String, dynamic> json) {
    return SlangModel(
      slangId: json['slang_id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  SlangModel copyWith({int? slangId, String? name, String? slug}) {
    return SlangModel(
      slangId: slangId ?? this.slangId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
    );
  }

  Map<String, dynamic> toJson() {
    return {'slang_id': slangId, 'name': name, 'slug': slug};
  }

  static List<SlangModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SlangModel.fromJson(json)).toList();
  }
}
