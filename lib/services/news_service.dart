import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String _apiKey = '82ca0043cc404753beaccf23dce4c475';
  static const String _baseUrl = 'newsapi.org';

  // ================= ESPORT ONLY =================
  Future<List<NewsModel>> fetchEsportNews() async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/everything',
      {
        'q': 'esports OR "e-sports" OR "pro gaming" OR "esport tournament"',
        'language': 'en',
        'sortBy': 'publishedAt',
        'pageSize': '20',
        'apiKey': _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'] ?? [];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil berita esport');
    }
  }

  // ================= SEARCH ESPORT =================
  Future<List<NewsModel>> searchEsportNews(String keyword) async {
    final uri = Uri.https(
      _baseUrl,
      '/v2/everything',
      {
        'q':
            '($keyword) AND (esports OR "e-sports" OR "pro gaming" OR tournament)',
        'language': 'en',
        'sortBy': 'publishedAt',
        'pageSize': '20',
        'apiKey': _apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'] ?? [];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mencari berita esport');
    }
  }
}
