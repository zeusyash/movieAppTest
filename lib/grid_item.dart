import 'package:flutter/material.dart';
import 'details_screen.dart';

class GridItem extends StatelessWidget {
  final dynamic movie;

  const GridItem({super.key, required this.movie});

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
              imageObj != null
                  ? Image.network(
                      imageObj['medium'],
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 150,
                    )
                  : Container(
                      color: Colors.grey,
                      height: 150,
                    ),
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
}
