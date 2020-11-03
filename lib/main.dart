import 'package:flutter/material.dart';
import 'package:hacker_news/src/model/article.dart';
import 'package:open_url/open_url.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final _articles = List.from(articles);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          setState(() {
            // _articles.removeAt(0);
          });
        },
        // child: ListView.builder(
        //   itemBuilder: (context, index) => _buildItem(_articles[index]),
        //   itemCount: _articles.length,
        // ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    final padding16dp = const EdgeInsets.all(16);
    final titleStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500);

    return Padding(
      padding: padding16dp,
      child: ExpansionTile(
        title: Text(
          article.text,
          style: titleStyle,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('${article.commentsCount} comments'),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  final result = await openUrl('https://${article.domain}');

                  if (result.exitCode == 0) {
                    print('URL should be open in your browser');
                  } else {
                    print('Something went wrong (exit code = ${result.exitCode}): ${result.stderr}');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
