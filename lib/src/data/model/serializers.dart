library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:hacker_news/src/data/model/story.dart';

part 'serializers.g.dart';

@SerializersFor([Story])
final Serializers serializers = _$serializers;

final jsonSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
