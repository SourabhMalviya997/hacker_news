import 'dart:convert';

import 'package:hacker_news/src/data/model/story.dart';
import 'package:hacker_news/src/data/model/serializers.dart';


List<int> parseArray(String jsonStr) {
  final json = jsonDecode(jsonStr);
  return List<int>.from(json);
}

Story parseStory(String jsonStr) {
  final json = jsonDecode(jsonStr);
  final article = jsonSerializers.deserializeWith(Story.serializer, json);
  return article;
}