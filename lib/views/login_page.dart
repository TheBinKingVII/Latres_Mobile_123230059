import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController controller = Get.find<AuthController>();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool obscureText = false;

  void _visibleTapped() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _loginTapped() {
    controller.login(usernameController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 18, 32),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(right: 24, left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_movies_rounded, size: 72, color: Colors.red),
              Text(
                "NontonSkuy",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              SizedBox(height: 16),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: _visibleTapped,
                    icon: obscureText
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _loginTapped();
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun?",
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed('/register');
                    },
                    child: Text(" Daftar", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
