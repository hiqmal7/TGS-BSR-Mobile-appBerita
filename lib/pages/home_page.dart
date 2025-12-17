import 'package:flutter/material.dart';
import 'package:tubes/models/news_model.dart';
import 'package:tubes/pages/foryou_page.dart';
import 'package:tubes/services/news_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0; // 0 = terbaru, 1 = terpopuler, 2 = for you
  late Future<List<NewsModel>> esportNews;

@override
  void initState() {
    super.initState();
    esportNews = NewsService().fetchEsportNews();
  }

  List<String> selectedBerita = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0E2A6E),
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset("assets/Logo.jpg", height: 40),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- TAB MENU ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTabButton("TERBARU", 0),
                buildTabButton("TERPOPULER", 1),
                buildTabButton("FOR YOU", 2),
              ],
            ),

            const SizedBox(height: 20),

            // ---------------- CONTENT BERDASARKAN TAB ----------------
            if (selectedTab == 0) buildTerbaru(),
            if (selectedTab == 1) buildTerpopuler(),
            if (selectedTab == 2) buildForYou(),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // WIDGET TAB BUTTON
  // =====================================================================
  Widget buildTabButton(String title, int index) {
    bool active = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.white : Colors.grey,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // =====================================================================
  // HALAMAN TERBARU
  // =====================================================================
 Widget buildTerbaru() {
  return FutureBuilder<List<NewsModel>>(
    future: esportNews,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Text(
          "Gagal memuat berita",
          style: TextStyle(color: Colors.white),
        );
      }

      final data = snapshot.data!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "BERITA ESPORTS",
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...data.map((e) => beritaCard(
                e.title,
                e.description,
                e.imageUrl,
              )),
        ],
      );
    },
  );
}


  // =====================================================================
  // HALAMAN TERPOPULER
  // =====================================================================
  Widget buildTerpopuler() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "BERITA ESPORTS",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...List.generate(4, (i) => beritaCard(
          "Terpopuler $i",
          "Deskripsi berita",
          "",
        )),
      ],
    );
  }

  // =====================================================================
  // HALAMAN FOR YOU
  // =====================================================================
 Widget buildForYou() {
  // jika belum pilih apa pun
  if (selectedBerita.isEmpty) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 60),
          const Text(
            "PILIH BERITA FAVORITMU",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Halaman ini akan diisi oleh berita yang\nAnda sukai",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 25),

          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForYouPage()),
              );

              if (result != null && result is List<String>) {
                setState(() {
                  selectedBerita = result;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2196F3),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "MULAI PILIH BERITA",
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // jika sudah ada data berita dari user
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "BERITA SESUAI MINATMU",
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),

      ...selectedBerita.map((item) => beritaCard(
        item,
        "Berita sesuai minat kamu",
        "",
      )),
    ],
  );
}


  // =====================================================================
  // CARD BERITA
  // =====================================================================
  Widget beritaCard(String title, String desc, String image) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14),
    decoration: BoxDecoration(
      color: const Color(0xFF2C2C2C),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Container(
          width: 90,
          height: 90,
          margin: const EdgeInsets.all(10),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image, size: 40),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Text(
                      "BACA SELENGKAPNYA",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    ),
                    Spacer(),
                    Icon(Icons.bookmark_border, color: Colors.white70),
                    SizedBox(width: 5),
                    Icon(Icons.share, color: Colors.white70),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
}
