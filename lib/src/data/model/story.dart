library story;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'story.g.dart';

abstract class Story implements Built<Story, StoryBuilder> {
  static Serializer<Story> get serializer => _$storySerializer;

  //fields
  @nullable
  int get id;

  @nullable
  bool get deleted;

  @nullable
  String get type;

  @nullable
  String get by;

  @nullable
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

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  @nullable
  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Story._();

  factory Story([updates(StoryBuilder builder)]) = _$Story;
}

enum StoryType { NEW, TOP }