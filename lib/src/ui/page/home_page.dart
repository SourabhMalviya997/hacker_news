import 'package:flutter/material.dart';
import 'package:hacker_news/src/bloc/bloc_provider.dart';
import 'package:hacker_news/src/bloc/story_bloc.dart';
import 'package:hacker_news/src/data/model/story.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storiesBloc = StoriesBloc();
  var _bottomNavBarItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StoriesBloc>(
      bloc: _storiesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: ProgressDialog(),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchStory(_storiesBloc));
              },
            )
          ],
        ),
        body: StoriesList(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavBarItemIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.near_me), label: "Top Stories"),
            BottomNavigationBarItem(icon: Icon(Icons.new_releases), label: "New Stories"),
          ],
          onTap: (index) {
            if (index != _bottomNavBarItemIndex) {
              if (index == 0) {
                _storiesBloc.storyType = StoryType.TOP;
              } else {
                _storiesBloc.storyType = StoryType.NEW;
              }
              setState(() {
                _bottomNavBarItemIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class StoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Story>>(
      builder: (context, snapshot) {
        return ListView(
          children: snapshot.data.map((article) => _buildItem(article)).toList(),
        );
      },
      initialData: <Story>[],
      stream: BlocProvider.of<StoriesBloc>(context).storiesStream,
    );
  }

  Widget _buildItem(Story story) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          story.title,
          style: const TextStyle(fontSize: 18),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${story.descendants} comments"),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  if (await canLaunch(story.url)) {
                    launch(story.url);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressDialog extends StatefulWidget {
  @override
  _ProgressDialogState createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: .5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.data) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        return FadeTransition(
          child: AppLogo(),
          opacity: _animationController,
        );
      },
      stream: BlocProvider.of<StoriesBloc>(context).progressStream,
    );
  }
}

class AppLogo extends StatelessWidget {
  final _text = "H";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87,
      child: Center(
        child: Text(
          _text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color:
                  Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.white),
        ),
      ),
    );
  }

  // bool isColorDark(Color color){
  //   final color = Color.
  // }
}

class SearchStory extends SearchDelegate<Story> {
  final StoriesBloc _storiesBloc;

  SearchStory(this._storiesBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<Story>>(
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final results = snapshot.data.where((story) => story.title.contains(query));

          return ListView(
            children: results.map((e) => Text(e.title)).toList(),
          );
        }

        return Center(child: Text("No Stories were found"));
      },
      initialData: <Story>[],
      stream: _storiesBloc.storiesStream,
    );
  }
}
