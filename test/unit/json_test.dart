import 'dart:io';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/data/client/hacker_news_client.dart';
import 'package:hacker_news/src/util/json_parser.dart';
import 'package:http/http.dart' as http;

main() {
  // test('Parsing json to Article', () {
  //   final story = """
  //   {
  //     "by" : "dhouston",
  //     "descendants" : 71,
  //     "id" : 8863,
  //     "kids" : [8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876],
  //     "score" : 111,
  //     "time" : 1175714200,
  //     "title" : "My YC app: Dropbox - Throw away your USB drive",
  //     "type" : "story",
  //     "url" : "http://www.getdropbox.com/u/2/screencast.html"
  //   }
  //   """;

  //   final jsonArray =
  //       "[8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940, 9067, 8908, 9055, 8865, 8881, 8872, 8873, 8955, 10403, 8903, 8928, 9125, 8998, 8901, 8902, 8907, 8894, 8878, 8870, 8980, 8934, 8876 ]";

  //   expect(parseArticle(story).by, 'dhouston');
  // });

  test('Fetching best stories from server', () async {
    final ids = await fetchBestStories();
    final article = await fetchArticle(ids.first);
    expect(article.by, "schappim");
  });
}
