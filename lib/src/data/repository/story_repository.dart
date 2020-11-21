import 'dart:collection';

import 'package:hacker_news/src/data/model/story.dart';
import 'package:hacker_news/src/data/provider/story_provider.dart';

class StoryRepository {
  final StoryProvider _storyProvider = StoryProvider();
  final _chachedStories = HashMap<int, Story>();

  Future<List<Story>> getStories(StoryType storyType) async {
    final storiesIds = await _storyProvider.fetchStories(storyType);

    final List<Story> storiesList = <Story>[];

    for (final id in storiesIds) {
      final article = await getStory(id);
      storiesList.add(article);
    }

    return storiesList;
  }

  Future<Story> getStory(int id) async {
    if (!_chachedStories.containsKey(id)) {
      _chachedStories[id] = await _storyProvider.fetchStory(id);
    }

    return _chachedStories[id];
  }
}
