import 'dart:async';

import 'package:hacker_news/src/bloc/bloc.dart';
import 'package:hacker_news/src/bloc/progress_bloc.dart';
import 'package:hacker_news/src/data/model/story.dart';
import 'package:hacker_news/src/data/repository/story_repository.dart';
import 'package:rxdart/rxdart.dart';

class StoriesBloc implements Bloc {
  final StreamController<List<Story>> _storiesStreamController = BehaviorSubject<List<Story>>();
  final StoryRepository _storyRepository = StoryRepository();
  final _StoryTypeBloc _storyTypeBloc = _StoryTypeBloc();
  final ProgressBloc _progressBloc = ProgressBloc();

  // constructor
  StoriesBloc() {
    _loadStories(StoryType.TOP);
    _storyTypeBloc.storyTypeStream.listen((storyType) {
        _loadStories(storyType);
    });
  }

  // getters
  Stream<List<Story>> get storiesStream => _storiesStreamController.stream;

  Stream<bool> get progressStream => _progressBloc.progressStream;

  Stream<StoryType> get storyTypeStream => _storyTypeBloc.storyTypeStream;

  // setters
  set storyType(StoryType storyType) {
    _storyTypeBloc.storyType = storyType;
    _progressBloc.progress = ProgressStatus.IN_PROGRESS;
  }
  
  void _loadStories(StoryType storyType) async {
    final stories = await _storyRepository.getStories(storyType);
    _storiesStreamController.sink.add(stories);
    _progressBloc.progress = ProgressStatus.COMPLETED;
  }

  @override
  void dispose() {
    _storiesStreamController.close();
    _progressBloc.dispose();
    _storyTypeBloc.dispose();
  }
}

class _StoryTypeBloc implements Bloc {
  final StreamController<StoryType> _storyTypeController = BehaviorSubject<StoryType>();

  // Constructor
  _StoryTypeBloc() {
    storyType = StoryType.TOP;
  }

  // getters
  Stream<StoryType> get storyTypeStream => _storyTypeController.stream;

  // setters
  set storyType(StoryType storyType) => _storyTypeController.sink.add(storyType);

  @override
  void dispose() {
    _storyTypeController.close();
  }
}