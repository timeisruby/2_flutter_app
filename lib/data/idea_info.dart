class IdeaInfo {
  int? id;
  String title;
  String motive;
  String content;
  int priority;
  String feedback;
  int createdAt;

  // 생성자 : 초기 값 : {} required
  IdeaInfo({
    this.id,
    required this.title,
    required this.motive,
    required this.content,
    required this.priority,
    required this.feedback,
    required this.createdAt,
  });

  // map convert
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'motive': motive,
      'content': content,
      'priority': priority,
      'feedback': feedback,
      'createdAt': createdAt,
    };
  }

  factory IdeaInfo.fromMap(Map<String, dynamic> map) {
    return IdeaInfo(
      id: map['id'],
      title: map["title"],
      motive: map["motive"],
      content: map["content"],
      priority: map["priority"],
      feedback: map["feedback"],
      createdAt: map["createdAt"],
    );
  }
}
