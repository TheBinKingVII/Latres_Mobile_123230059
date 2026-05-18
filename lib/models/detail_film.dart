import 'package:hive/hive.dart';
part 'detail_film.g.dart';

@HiveType(typeId: 0)
class DetailFilm extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String url;
  @HiveField(2)
  String name;
  @HiveField(3)
  List<String> genres;
  @HiveField(4)
  double rating;
  @HiveField(5)
  String summary;
  @HiveField(6)
  String imgUrl;

  DetailFilm({
    required this.id,
    required this.url,
    required this.name,
    required this.genres,
    required this.rating,
    required this.summary,
    required this.imgUrl,
  });

  factory DetailFilm.fromJson(Map<String, dynamic> json) {
    return DetailFilm(
      id: json['id'],
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      genres: List<String>.from(json['genres']),
      rating: (json['rating']['average'] ?? 0).toDouble(),
      summary: json['summary'] ?? '',
      imgUrl: json['image']['original'] ?? '',
    );
  }
}
