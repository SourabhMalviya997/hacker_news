import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/src/data/model/story.dart';
import 'package:hacker_news/src/data/provider/story_provider.dart';

main() {
  final articleProvider = StoryProvider();

  test('Fetching best stories from server', () async {
    final ids = await articleProvider.fetchStories(StoryType.TOP);
    final article = await articleProvider.fetchStory(ids.first);
    expect(article.by, "schappim");
  });
}
