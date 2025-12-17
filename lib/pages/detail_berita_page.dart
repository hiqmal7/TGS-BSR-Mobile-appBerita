import 'package:flutter/material.dart';
import '../models/news_model.dart';

class DetailBeritaPage extends StatelessWidget {
  final NewsModel news;

  const DetailBeritaPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E2A6E),
        title: const Text("Berita Esports"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER IMAGE =================
            if (news.imageUrl.isNotEmpty)
              Image.network(
                news.imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(height: 240, color: Colors.grey),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= JUDUL =================
                  Text(
                    news.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ================= TANGGAL =================
                  Text(
                    news.publishedAt,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),

                  const SizedBox(height: 20),

                  // ================= ISI ARTIKEL =================
                  Text(
                    news.content.isNotEmpty ? news.content : news.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.6,
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
