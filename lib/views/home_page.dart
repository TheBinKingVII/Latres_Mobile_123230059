import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/film_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _onItemTapped(int id) {
    Get.toNamed('/detail', arguments: {'id': id});
  }

  @override
  Widget build(BuildContext context) {
    FilmController controller = Get.find<FilmController>();
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      }

      if (controller.filmList.isEmpty) {
        return Center(child: Text("Tidak ada film yang tersedia"));
      }

      return Padding(
        padding: EdgeInsetsGeometry.only(left: 16, right: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final film = controller.filmList[index];
            return InkWell(
              onTap: () => {_onItemTapped(film.id)},
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(24),
                child: Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(
                          film.imgUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                film.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amberAccent),
                                  Text(film.rating.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: controller.filmList.length,
        ),
      );
    });
  }
}
