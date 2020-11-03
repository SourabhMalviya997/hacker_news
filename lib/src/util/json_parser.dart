import 'package:hacker_news/src/model/article.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hacker_news/src/model/serializers.dart';

List<int> parseJsonArray(String jsonStr) {
  final json = jsonDecode(jsonStr);
  return List<int>.from(json);
}

Article parseArticle(String jsonStr) {
  final json = jsonDecode(jsonStr);
  final article = jsonSerializers.deserializeWith(Article.serializer, json);
  return article;
}

