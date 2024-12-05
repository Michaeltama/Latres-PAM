import 'package:flutter/material.dart';
import 'package:latres/pages/list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, $_username"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 70, 60, 87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuCard(
              title: "News",
              description: "Get an overview of the latest spaceflight news!",
              endpoint: "articles",
              icon: Icons.article,
            ),
            SizedBox(height: 20),
            MenuCard(
              title: "Blogs",
              description: "Blogs often Provide a more detailed overview ",
              endpoint: "blogs",
              icon: Icons.book,
            ),
            SizedBox(height: 20),
            MenuCard(
              title: "Reports",
              description: "Space stations and other missions",
              endpoint: "reports",
              icon: Icons.report,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final String endpoint;
  final IconData icon;

  const MenuCard({
    required this.title,
    required this.description,
    required this.endpoint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListScreen(endpoint: endpoint),
          ),
        );
      },
      child: Container(
        height: 120, // Tambahkan tinggi tetap untuk memperbesar ukuran
        padding: EdgeInsets.all(20), // Tingkatkan padding untuk kesan luas
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromARGB(255, 98, 85, 121), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 50, color: const Color.fromARGB(255, 73, 64, 89)), // Ukuran ikon lebih besar
            SizedBox(width: 20), // Tambah jarak antar ikon dan teks
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan teks
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20, // Ukuran teks lebih besar
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 59, 52, 71),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16, // Ukuran deskripsi lebih besar
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
