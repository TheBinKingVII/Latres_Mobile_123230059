import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:latihan_responsi_praktpm/controllers/favorite_controller.dart';
import 'package:latihan_responsi_praktpm/controllers/film_controller.dart';
import 'package:latihan_responsi_praktpm/models/film.dart';

class DetailPage extends StatefulWidget {
  DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Film> futureFilm;
  FavoriteController controllerFav = Get.find<FavoriteController>();
  FilmController controller = Get.find<FilmController>();
  final data = Get.arguments;
  get filmId => data['id'];

  @override
  void initState() {
    super.initState();
    futureFilm = controller.fetchFilmDetails(filmId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail")),
      body: FutureBuilder(
        future: futureFilm,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Data detail tidak tersedia"));
          }

          final film = snapshot.data!;
          return Obx(() {
            final isFavorite = controllerFav.favoriteFilm.any(
              (item) => item.id == film.id,
            );

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.network(film.imgUrl),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
