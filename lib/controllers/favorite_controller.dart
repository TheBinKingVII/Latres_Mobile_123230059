import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:latihan_responsi_praktpm/models/detail_film.dart';

class FavoriteController extends GetxController {
  static const String boxName = "favorite_box";

  late Box<DetailFilm> _favoriteBox;
  final RxList<DetailFilm> favoriteFilm = <DetailFilm>[].obs;

  @override
  void onInit() {
    _favoriteBox = Hive.box<DetailFilm>(boxName);
    _syncFromBox();
    super.onInit();
  }

  void _syncFromBox() {
    final items = _favoriteBox.values.toList();
    favoriteFilm.assignAll(items);
  }

  bool isFavorite(int mealId) {
    return _favoriteBox.containsKey(mealId);
  }

  Future<void> addFavorite(DetailFilm meal) async {
    await _favoriteBox.put(meal.id, meal);
    _syncFromBox();
  }

  Future<void> removeFavorite(int mealId) async {
    await _favoriteBox.delete(mealId);
    _syncFromBox();
  }
}
