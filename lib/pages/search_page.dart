import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final List<String> allBerita = [
    "Mobile Legends World Championship",
    "PUBG Mobile Pro League",
    "Valorant Champions Tour",
    "Free Fire World Series",
    "Dota 2 The International",
  ];

  List<String> hasilPencarian = [];

  void cariBerita(String query) {
    setState(() {
      hasilPencarian = allBerita
          .where((judul) => judul.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Search", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                onChanged: cariBerita,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white54),
                  hintText: "Cari berita esports...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📃 Hasil Pencarian
            Expanded(
              child: hasilPencarian.isEmpty && searchController.text.isNotEmpty
                  ? const Center(
                      child: Text(
                        "Berita tidak ditemukan",
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.separated(
                      itemCount: hasilPencarian.isEmpty
                          ? allBerita.length
                          : hasilPencarian.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final title = hasilPencarian.isEmpty
                            ? allBerita[index]
                            : hasilPencarian[index];

                        return beritaSearchCard(title, context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget beritaSearchCard(String title, BuildContext context) {
  return GestureDetector(
    onTap: () {
      // nanti arahkan ke DetailBeritaPage
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
        ],
      ),
    ),
  );
}
