import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLogin = false.obs;

  @override
  void onInit() {
    checkLogin();
    super.onInit();
  }

  Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
    await prefs.setString('password', password);

    Get.snackbar("Success", "Register berhasil");

    Get.offAllNamed('/login');
  }

  Future<void> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (username == savedUsername && password == savedPassword) {
      await prefs.setBool('isLogin', true);

      Get.snackbar('Succes', "Berhasil login");

      Get.offAllNamed('/main');
    } else if (username == "" || password == "") {
      Get.snackbar('Error', "Mohon masukkan Username atau Password");
    } else {
      Get.snackbar('Error', "Username atau Password Salah");
    }
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    bool loginStatus = prefs.getBool('isLogin') ?? false;

    isLogin.value = loginStatus;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogin', false);

    isLogin.value = false;

    Get.offAllNamed('/login');
  }
}
