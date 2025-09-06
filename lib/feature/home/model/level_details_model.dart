class LevelDetails {
  final int levelId;
  final String name;
  final int order;
  final String description;
  final Progress progress;
  final bool unlocked;
  final List<Block> blocks;

  LevelDetails({
    required this.levelId,
    required this.name,
    required this.order,
    required this.description,
    required this.progress,
    required this.unlocked,
    required this.blocks,
  });

  factory LevelDetails.fromJson(Map<String, dynamic> json) {
    return LevelDetails(
      levelId: json['level_id'],
      name: json['name'],
      order: json['order'],
      description: json['description'],
      progress: Progress.fromJson(json['progress']),
      unlocked: json['unlocked'],
      blocks: (json['blocks'] as List)
          .map((e) => Block.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'level_id': levelId,
    'name': name,
    'order': order,
    'description': description,
    'progress': progress.toJson(),
    'unlocked': unlocked,
    'blocks': blocks.map((e) => e.toJson()).toList(),
  };

  static List<LevelDetails> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LevelDetails.fromJson(json)).toList();
  }


}

class Progress {
  final int total;
  final int completedCount;
  final int perfectedCount;
  final List<int> completedLessons;
  final int? nextLessonId;

  Progress({
    required this.total,
    required this.completedCount,
    required this.perfectedCount,
    required this.completedLessons,
    this.nextLessonId,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      total: json['total'],
      completedCount: json['completed_count'],
      perfectedCount: json['perfected_count'],
      completedLessons: List<int>.from(json['completed_lessons']),
      nextLessonId: json['next_lesson_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'completed_count': completedCount,
    'perfected_count': perfectedCount,
    'completed_lessons': completedLessons,
    'next_lesson_id': nextLessonId,
  };
}

class Block {
  final int blockId;
  final String blockName;
  final List<Group> groups;

  Block({
    required this.blockId,
    required this.blockName,
    required this.groups,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      blockId: json['block_id'],
      blockName: json['block_name'],
      groups: (json['groups'] as List)
          .map((e) => Group.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'block_id': blockId,
    'block_name': blockName,
    'groups': groups.map((e) => e.toJson()).toList(),
  };
}

class Group {
  final int groupId;
  final String groupName;
  final String description;
  final int totalLessons;
  final int completedCount;
  final int perfectedCount;
  final int totalXp;
  final int totalGems;
  final List<Lesson> lessons;

  Group({
    required this.groupId,
    required this.groupName,
    required this.description,
    required this.totalLessons,
    required this.completedCount,
    required this.perfectedCount,
    required this.totalXp,
    required this.totalGems,
    required this.lessons,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupId: json['group_id'],
      groupName: json['group_name'],
      description: json['description'],
      totalLessons: json['total_lessons'],
      completedCount: json['completed_count'],
      perfectedCount: json['perfected_count'],
      totalXp: json['total_xp'],
      totalGems: json['total_gems'],
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'group_id': groupId,
    'group_name': groupName,
    'description': description,
    'total_lessons': totalLessons,
    'completed_count': completedCount,
    'perfected_count': perfectedCount,
    'total_xp': totalXp,
    'total_gems': totalGems,
    'lessons': lessons.map((e) => e.toJson()).toList(),
  };
}

class Lesson {
  final int lessonId;
  final String title;
  final String question;
  final String recognitionScale;
  final String sampleAnswer;
  final bool manualReview;
  final int xp;
  final int gems;
  final bool completed;
  final bool unlocked;
  final bool perfected;

  Lesson({
    required this.lessonId,
    required this.title,
    required this.question,
    required this.recognitionScale,
    required this.sampleAnswer,
    required this.manualReview,
    required this.xp,
    required this.gems,
    required this.completed,
    required this.unlocked,
    required this.perfected,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lesson_id'],
      title: json['title'],
      question: json['question'],
      recognitionScale: json['recognition_scale'],
      sampleAnswer: json['sample_answer'],
      manualReview: json['manual_review'],
      xp: json['xp'],
      gems: json['gems'],
      completed: json['completed'],
      unlocked: json['unlocked'],
      perfected: json['perfected'],
    );
  }

  Map<String, dynamic> toJson() => {
    'lesson_id': lessonId,
    'title': title,
    'question': question,
    'recognition_scale': recognitionScale,
    'sample_answer': sampleAnswer,
    'manual_review': manualReview,
    'xp': xp,
    'gems': gems,
    'completed': completed,
    'unlocked': unlocked,
    'perfected': perfected,
  };
}
