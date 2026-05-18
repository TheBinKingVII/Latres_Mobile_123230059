import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/auth_controller.dart';
import 'package:latihan_responsi_praktpm/controllers/film_controller.dart';
import 'package:latihan_responsi_praktpm/views/login_page.dart';
import 'package:latihan_responsi_praktpm/views/main_page.dart';
import 'package:latihan_responsi_praktpm/views/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final loginStatus = prefs.getBool('isLogin') ?? false;

  Get.put(AuthController());
  Get.put(FilmController());
  runApp(MainApp(initialRoute: loginStatus ? '/main' : '/login'));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/main', page: () => MainPage()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
