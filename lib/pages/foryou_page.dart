import 'package:flutter/material.dart';

class ForYouPage extends StatefulWidget {
  const ForYouPage({super.key});

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> {
  List<String> selected = [];

  Map<String, List<String>> kategori = {
    "MOBA": [
      "Mobile Legends",
      "Honor Of King",
      "Arena Of Valor",
      "DOTA 2",
      "League Of Legends"
    ],
    "FPS": [
      "Call Of Duty : Warzone",
      "Valorant",
      "Battlefield",
    ],
    "Battle Ground": [
      "PUBG",
      "Free Fire",
      "Apex Legends",
      "Fortnite"
    ],
    "Strategi": [
      "Class Of Clans",
      "Teamfight Tactics",
      "Magic Chess: Go Go",
      "Class Royal"
    ],
    "MMORPG": [
      "Genshin Impact",
      "Wuthering Waves"
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

       appBar: AppBar(
          backgroundColor: const Color(0xFF0E2A6E),
          toolbarHeight: 70,
          titleSpacing: 0,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    "assets/Logo.jpg",
                    height: 40,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'FOR YOU',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

      body: buildSelectionPage(),
    );
  }

  // ===================================================================
  // Halaman pemilihan kategori
  // ===================================================================
  Widget buildSelectionPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "PILIH 3 BERITA ATAU LEBIH UNTUK LANJUT",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),

          ...kategori.entries.map((e) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.key,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),

                Wrap(
                  spacing: 8,
                  children: e.value.map((g) {
                    final isSelected = selected.contains(g);

                    return ChoiceChip(
                      label: Text(
                        g,
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white70,
                            fontSize: 12),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.blue.shade600,
                      backgroundColor: const Color(0xFF2C2C2C),
                      onSelected: (v) {
                        setState(() {
                          v ? selected.add(g) : selected.remove(g);
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),
              ],
            );
          }).toList(),

          const SizedBox(height: 20),

          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: selected.length >= 3
                  ? () {
                      Navigator.pop(context, selected); // <--- KIRIM DATA KE HOMEPAGE
                    }
                  : null,
              child: const Text(
                "SIMPAN BERITA",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
