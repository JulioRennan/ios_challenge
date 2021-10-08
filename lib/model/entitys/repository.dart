import 'dart:convert';

class Repository {
  int id;
  /*
    os campos do proprietários do repo, foram pegos para deixar o card com uma estética mais agradável,
    tornando desnecessário criar um model a parte.
   */
  String ownerName;
  String ownerUrlAvatar;

  String name;
  String fullName;
  String language;
  String description;

  int stargazersCount;
  Repository({
    required this.id,
    required this.name,
    required this.fullName,
    required this.language,
    required this.description,
    required this.ownerName,
    required this.ownerUrlAvatar,
    required this.stargazersCount,
  });
  get getCountStartFormated {
    if (stargazersCount >= 1000) {
      return "${(stargazersCount / 1000).toStringAsFixed(1)}K";
    } else {
      return stargazersCount.toString();
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_name': ownerName,
      'owner_url_avatar': ownerUrlAvatar,
      'name': name,
      'full_name': fullName,
      'language': language,
      'description': description,
      'stargazers_count': stargazersCount,
    };
  }

  factory Repository.fromJson(Map<String, dynamic> map, {bool fromDb = false}) {
    return Repository(
      id: map['id'],
      ownerName: fromDb ? map['owner_name'] : map['owner']['login'],
      ownerUrlAvatar:
          fromDb ? map['owner_url_avatar'] : map['owner']['avatar_url'],
      name: map['name'],
      fullName: map['full_name'],
      language: map['language'],
      description: map['description'] ?? "",
      stargazersCount: map['stargazers_count'],
    );
  }

  String toJson() => json.encode(toMap());
}
