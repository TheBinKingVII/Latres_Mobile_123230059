import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan_responsi_praktpm/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Pengguna';
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // Avatar
          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.red,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: const Color.fromARGB(255, 10, 35, 56),
              child: Text(
                _username.isNotEmpty ? _username[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Username
          Text(
            _username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Anggota Aktif',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),

          const SizedBox(height: 32),

          // Info card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 35, 56),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Informasi Akun',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Divider(color: Colors.white24, height: 24),
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        color: Colors.redAccent, size: 20),
                    const SizedBox(width: 12),
                    const Text('Username',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Spacer(),
                    Text(
                      _username,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Kesan & Pesan card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 10, 35, 56),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Kesan & Pesan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white24, height: 24),
                const Text(
                  'Kesan:',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Praktikum TPM sangat seru dan menantang! Banyak hal baru yang dipelajari, terutama tentang pengembangan aplikasi mobile menggunakan Flutter. Setiap minggu selalu ada tantangan baru yang membuat semangat belajar semakin meningkat.',
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pesan:',
                  style: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Terima kasih kepada seluruh asisten praktikum yang sudah dengan sabar membimbing dan menjelaskan materi dengan sangat baik. Semoga praktikum TPM ke depannya semakin baik dan materinya semakin menarik. Sukses selalu untuk para asisten!',
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Logout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Logout',
                  middleText: 'Apakah kamu yakin ingin logout?',
                  textConfirm: 'Logout',
                  textCancel: 'Batal',
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    authController.logout();
                  },
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
