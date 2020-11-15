library article;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  //fields
  int get id;

  @nullable
  bool get deleted;

  String get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  String get url;

  int get score;

  String get title;

  @nullable
  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Article._();

  factory Article([updates(ArticleBuilder builder)]) = _$Article;
}
