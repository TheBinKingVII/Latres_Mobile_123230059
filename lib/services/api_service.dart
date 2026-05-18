import 'dart:convert';

import 'package:latihan_responsi_praktpm/models/film.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = " https://api.tvmaze.com/shows";

  static Future<List<Film>> getFilmList() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final filmsJson = List<Map<String, dynamic>>.from(data);

        return filmsJson.map((e) => Film.fromJson(e)).toList();
      } else {
        throw Exception("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Ada Kesalahan yang terjadi ${e.toString()}");
    }
  }

  static Future<Film> getFilmDetailById(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/$id"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final filmJson = Map<String, dynamic>.from(data);
        return Film.fromJson(filmJson);
      } else {
        throw Exception("Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Ada Kesalahan yang terjadi ${e.toString()}");
    }
  }
}
