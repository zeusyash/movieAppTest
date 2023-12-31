import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  const DetailsScreen(this.movie, {super.key});
  String parseHtml(String htmlString) {
    var document = parse(htmlString);
    return parse(document.body!.text).documentElement!.text;
  }

  @override
  Widget build(BuildContext context) {
    var imageObj = movie['image'];
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageObj != null
                ? Image.network(
                    movie['image']['original'],
                    height: 600,
                  )
                : Container(
                    color: Colors.grey,
                    height: 600,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                parseHtml(movie['summary']),
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
