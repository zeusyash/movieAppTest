// grid_item.dart
import 'package:flutter/material.dart';
import 'details_screen.dart'; // Import the DetailsScreen
//import 'package:flutter_html/flutter_html.dart';

class GridItem extends StatelessWidget {
  final dynamic movie;

  GridItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    var imageObj = movie['image'];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(movie),
          ),
        );
      },
      child: GridTile(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Big Image
              imageObj != null
                  ? Image.network(
                      imageObj['medium'],
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 150,
                    )
                  : Container(
                      color: Colors.grey, // Placeholder color
                      height: 150,
                    ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  movie['name'],
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSummaryLines(String summary) {
    // Split summary into lines and return the first 3 lines
    List<String> lines = summary.split('\n');
    return lines.length >= 3 ? lines.sublist(0, 3).join('\n') : summary;
  }
}
