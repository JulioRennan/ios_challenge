import 'dart:convert';

class Pull {
  int id;
  int number;
  String url;
  String title;
  DateTime createdAt;
  DateTime? mergedAt;
  String state;
  String body;
  Pull({
    required this.id,
    required this.number,
    required this.url,
    required this.title,
    required this.createdAt,
    required this.body,
    required this.state,
    required this.mergedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'url': url,
      'title': title,
      'createdAt': createdAt,
      'mergedAt': mergedAt,
      'body': body,
      'state': state
    };
  }

  factory Pull.fromMap(Map<String, dynamic> map) {
    return Pull(
      id: map['id'],
      number: map['number'],
      url: map['url'],
      body: map['body'] ?? "",
      state: map['state'],
      title: map['title'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      mergedAt:
          map['mergedAt'] == null ? null : DateTime.parse(map['mergedAt']),
    );
  }
  factory Pull.fromJson(Map<String, dynamic> map) {
    return Pull(
      id: map['id'],
      number: map['number'],
      body: map['body'] ?? "",
      url: map['url'],
      state: map['state'],
      title: map['title'],
      createdAt: DateTime.parse(map['created_at']),
      mergedAt:
          map['merged_at'] == null ? null : DateTime.parse(map['merged_at']),
    );
  }

  @override
  String toString() {
    return 'Pull(id: $id, number: $number, url: $url, title: $title, createdAt: $createdAt, mergedAt: $mergedAt)';
  }
}
