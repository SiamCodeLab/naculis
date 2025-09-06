class LevelModel {
  final int levelId;
  final String name;
  final int order;
  final String description;
  final int totalLessons;
  final int completedCount;
  final bool unlocked;

  LevelModel({
    required this.levelId,
    required this.name,
    required this.order,
    required this.description,
    required this.totalLessons,
    required this.completedCount,
    required this.unlocked,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      levelId: json['level_id'] ?? 0,
      name: json['name'] ?? '',
      order: json['order'] ?? 0,
      description: json['description'] ?? '',
      totalLessons: json['total_lessons'] ?? 0,
      completedCount: json['completed_count'] ?? 0,
      unlocked: json['unlocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level_id': levelId,
      'name': name,
      'order': order,
      'description': description,
      'total_lessons': totalLessons,
      'completed_count': completedCount,
      'unlocked': unlocked,
    };
  }

  static List<LevelModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LevelModel.fromJson(json)).toList();
  }

  @override
  String toString() {
    return 'LevelModel(levelId: $levelId, name: $name, order: $order, '
        'description: $description, totalLessons: $totalLessons, '
        'completedCount: $completedCount, unlocked: $unlocked)';
  }
}
