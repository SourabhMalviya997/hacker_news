library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:hacker_news/src/model/article.dart';

part 'serializers.g.dart';

@SerializersFor([Article])
final Serializers serializers = _$serializers;

final jsonSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
