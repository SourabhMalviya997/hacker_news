import 'dart:convert';
import 'package:hacker_news/src/model/article.dart';
import 'package:hacker_news/src/util/json_parser.dart';
import 'package:http/http.dart' as http;

Future<List<int>> fetchBestStories() async {
  const url = 'https://hacker-news.firebaseio.com/v0/beststories.json';
  final res = await http.get(url);

  if (res.statusCode == 200) {
    return List<int>.from(jsonDecode(res.body));
  }

  return List<int>(0);
}

Future<Article> fetchArticle(int id) async {
  final url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
  final res = await http.get(url);

  if (res.statusCode == 200) {
    return parseArticle(res.body);
  }

  return null;
}
