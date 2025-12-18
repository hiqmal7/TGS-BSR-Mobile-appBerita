import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';
import 'detail_berita_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  List<NewsModel> hasilPencarian = [];
  bool isLoading = false;
  String error = '';

  Future<void> cariBerita(String query) async {
    if (query.isEmpty) {
      setState(() => hasilPencarian = []);
      return;
    }

    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final result = await NewsService().searchEsportNews(query);
      setState(() {
        hasilPencarian = result;
      });
    } catch (e) {
      print('ERROR SEARCH: $e');
      setState(() {
        error = 'Gagal memuat berita';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
            // ================= SEARCH BAR =================
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

            // ================= RESULT =================
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : error.isNotEmpty
                  ? Center(
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.white54),
                      ),
                    )
                  : hasilPencarian.isEmpty
                  ? const Center(
                      child: Text(
                        "Tidak ada hasil",
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.separated(
                      itemCount: hasilPencarian.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final news = hasilPencarian[index];
                        return beritaSearchCard(news, context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget beritaSearchCard(NewsModel news, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailBeritaPage(news: news)),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // ================= IMAGE =================
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: news.imageUrl.isNotEmpty
                ? Image.network(
                    news.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image, color: Colors.white54),
                  )
                : const Icon(Icons.image, color: Colors.white54),
          ),

          const SizedBox(width: 12),

          // ================= TITLE =================
          Expanded(
            child: Text(
              news.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
