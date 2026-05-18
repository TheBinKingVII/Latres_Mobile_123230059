import 'package:flutter/foundation.dart';

class Film {
  int id;
  String url;
  String name;
  List<String> genres;
  double rating;
  String summary;

  Film({
    required this.id,
    required this.url,
    required this.name,
    required this.genres,
    required this.rating,
    required this.summary,
  });

  factory Film.fromJson(Map<String, dynamic> json) {
    return Film(
      id: json['id'],
      url: json['url'] ?? '',
      name: json['name'] ?? '',
      genres: List<String>.from(json['genres']),
      rating: (json['rating']['average'] ?? 0).toDouble(),
      summary: json['summary'] ?? '',
    );
  }
}
