import 'dart:async';

import 'package:hacker_news/src/bloc/bloc.dart';
import 'package:rxdart/subjects.dart';

class ProgressBloc implements Bloc {
  final StreamController<bool> _progressStreamController = BehaviorSubject<bool>();

  // constructor
  ProgressBloc() {
    this.progress = ProgressStatus.IN_PROGRESS;
  }

  // getters
  Stream<bool> get progressStream => _progressStreamController.stream;

  // setters
  set progress(ProgressStatus status) {
    switch (status) {
      case ProgressStatus.COMPLETED:
        _progressStreamController.sink.add(true);
        break;
      default:
        _progressStreamController.sink.add(false);
    }
  }

  @override
  void dispose() {
    _progressStreamController.close();
  }
}

enum ProgressStatus { IN_PROGRESS, COMPLETED }
