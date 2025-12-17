import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  static const String _apiKey = '82ca0043cc404753beaccf23dce4c475';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsModel>> fetchEsportNews() async {
    final url = Uri.parse(
      'https://newsapi.org/v2/everything?q=game OR esports&language=en',
    );

    final response = await http.get(url, headers: {'X-Api-Key': _apiKey});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List articles = data['articles'];

      return articles.map((e) => NewsModel.fromJson(e)).toList();
    } else {
      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');
      throw Exception('Gagal mengambil berita');
    }
  }
}
