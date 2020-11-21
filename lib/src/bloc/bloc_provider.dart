import 'package:flutter/cupertino.dart';
import 'package:hacker_news/src/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  BlocProvider({this.child, this.bloc});

  static T of<T extends Bloc>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<BlocProvider<T>>().bloc;
  }

  @override
  _BlocProviderState createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) => widget.child;


  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
