import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/favorite_controller.dart';
import 'package:latihan_responsi_praktpm/models/detail_film.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favController = Get.find<FavoriteController>();

    return Obx(() {
      final List<DetailFilm> favorites = favController.favoriteFilm;

      if (favorites.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'Belum ada TV Show favorit',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final film = favorites[index];
          return Card(
            color: const Color.fromARGB(255, 10, 35, 56),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Get.toNamed('/detail', arguments: {'id': film.id});
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    // Thumbnail
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        film.imgUrl,
                        width: 80,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 80,
                          height: 110,
                          color: Colors.grey[800],
                          child: const Icon(Icons.broken_image,
                              color: Colors.white54),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            film.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amberAccent, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                film.rating.toString(),
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: film.genres
                                .take(3)
                                .map(
                                  (g) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.red, width: 0.5),
                                    ),
                                    child: Text(
                                      g,
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 11),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    // Delete button
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      tooltip: 'Hapus dari favorit',
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Hapus Favorit',
                          middleText:
                              'Hapus "${film.name}" dari daftar favorit?',
                          textConfirm: 'Hapus',
                          textCancel: 'Batal',
                          confirmTextColor: Colors.white,
                          buttonColor: Colors.red,
                          onConfirm: () {
                            favController.removeFavorite(film.id);
                            Get.back();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
