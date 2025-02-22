import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Image
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                    'assets/images/man.png'), // Replace with your image path
              ),
            ),
            const SizedBox(height: 20),
            // Name
            const Text(
              'Syahid Muhammad Umar', // Replace with user's name
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Bio or Role
            const Text(
              'Mahasiswa Universitas Binasarana Informatika',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const Text(
              '12221032',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1, color: Colors.grey),
            // Contact Info Section
            _buildProfileInfo(
                'Email', 'xcplus.tsm.syahid@gmail.com', Icons.email),
            _buildProfileInfo('Telepon', '085697482053', Icons.phone),
            _buildProfileInfo(
                'Lokasi', 'karawang, indonesia', Icons.location_on),
            const Divider(thickness: 1, color: Colors.grey),
            // Additional Info Section
            _buildProfileInfo(
                'Tanggal Lahir', '17 Agustus, 2002', Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  // Reusable method to build profile info
  Widget _buildProfileInfo(String title, String info, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueGrey,
            size: 30,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                info,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
