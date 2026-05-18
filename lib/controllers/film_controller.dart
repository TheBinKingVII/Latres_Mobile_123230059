import 'package:get/state_manager.dart';
import 'package:latihan_responsi_praktpm/models/film.dart';
import 'package:latihan_responsi_praktpm/services/api_service.dart';

class FilmController extends GetxController {
  var _filmList = [].obs;
  RxBool _isLoading = true.obs;

  List get filmList => _filmList;
  RxBool get isLoading => _isLoading;

  set filmList(List<Film> value) {
    _filmList.value = value;
  }

  set isLoading(bool value) {
    _isLoading.value = value;
  }

  @override
  void onInit() {
    fetchFilms();
    super.onInit();
  }

  void fetchFilms() async {
    try {
      _isLoading.value = true;
      var data = await ApiService.getFilmList();
      _filmList.value = data;
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  Future<Film> fetchFilmDetails(int id) async {
    try {
      var data = await ApiService.getFilmDetailById(id);
      return data;
    } catch (e) {
      print("Error: $e");
      throw Exception('Film detail not found');
    } finally {
      _isLoading.value = false;
    }
  }
}
