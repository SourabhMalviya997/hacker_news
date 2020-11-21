import 'dart:io';

import 'package:hacker_news/src/data/model/story.dart';
import 'package:hacker_news/src/util/json_parser.dart';
import 'package:http/http.dart' as http;

class StoryProvider {
  static const _baseUrl = "https://hacker-news.firebaseio.com/v0/";

  // fetch ids of top 500 best articles
  Future<List<int>> fetchStories(StoryType storyType) async {
    final url =
        '$_baseUrl${storyType == StoryType.TOP ? "topstories" : "newstories"}.json';
    final res = await http.get(url);

    if (res.statusCode == 200) {
      return parseArray(res.body).take(10).toList();
    }

    return List<int>(0);
  }

  // fetch an article
  Future<Story> fetchStory(int id) async {
    final articleUrl = '$_baseUrl/item/$id.json';
    final articleRes = await http.get(articleUrl);

    if (articleRes.statusCode == 200) {
      return parseStory(articleRes.body);
    }else{
      throw WebSocketException("Error Loading Url");
    }
  }
}
