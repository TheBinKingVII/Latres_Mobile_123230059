import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/favorite_controller.dart';
import 'package:latihan_responsi_praktpm/controllers/film_controller.dart';
import 'package:latihan_responsi_praktpm/models/detail_film.dart';
import 'package:latihan_responsi_praktpm/models/film.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Film> futureFilm;
  final FavoriteController controllerFav = Get.find<FavoriteController>();
  final FilmController controller = Get.find<FilmController>();
  late final int filmId;

  @override
  void initState() {
    super.initState();
    filmId = Get.arguments['id'] as int;
    futureFilm = controller.fetchFilmDetails(filmId);
  }

  /// Strip HTML tags from summary
  String _stripHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  void _toggleFavorite(Film film, bool isFavorite) {
    if (isFavorite) {
      controllerFav.removeFavorite(film.id);
      Get.snackbar(
        'Dihapus',
        '${film.name} dihapus dari favorit',
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        icon: const Icon(Icons.bookmark_remove, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    } else {
      controllerFav.addFavorite(
        DetailFilm(
          id: film.id,
          url: film.url,
          name: film.name,
          genres: film.genres,
          rating: film.rating,
          summary: film.summary,
          imgUrl: film.imgUrl,
        ),
      );
      Get.snackbar(
        'Ditambahkan',
        '${film.name} ditambahkan ke favorit',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 8,
        icon: const Icon(Icons.bookmark_added, color: Colors.white),
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Detail',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: FutureBuilder<Film>(
        future: futureFilm,
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 56,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Gagal memuat data',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          futureFilm = controller.fetchFilmDetails(filmId);
                        });
                      },
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        'Coba Lagi',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Empty state
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Data detail tidak tersedia',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final film = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Poster image ──────────────────────────────────────────
                Stack(
                  children: [
                    Image.network(
                      film.imgUrl,
                      width: double.infinity,
                      height: 320,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 320,
                        color: Colors.grey[900],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white54,
                          size: 64,
                        ),
                      ),
                    ),
                    // Gradient overlay at the bottom of the poster
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Color(0xFF0A0A0A), Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Content ───────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Title
                      Text(
                        film.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Rating + genres row
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            film.rating.toString(),
                            style: const TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (film.genres.isNotEmpty) ...[
                            const SizedBox(width: 10),
                            const Text(
                              '·',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                film.genres.join(', '),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Nonton button + Favorite button ──────────────────
                      Row(
                        children: [
                          // Nonton button
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // TODO: Aksi nonton
                              },
                              icon: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              label: const Text(
                                'Nonton',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Obx(() {
                            final isFavorite = controllerFav.favoriteFilm.any(
                              (item) => item.id == film.id,
                            );

                            return GestureDetector(
                              onTap: () => _toggleFavorite(film, isFavorite),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E1E1E),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  isFavorite
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  color: isFavorite ? Colors.red : Colors.white,
                                  size: 24,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // ── Overview section ──────────────────────────────────
                      const Text(
                        'Overview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        film.summary.isNotEmpty
                            ? _stripHtml(film.summary)
                            : 'Tidak ada sinopsis.',
                        style: const TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
