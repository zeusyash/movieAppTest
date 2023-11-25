// search_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_screen.dart';
import 'grid_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search movies...',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Going in search movies');
              searchMovies();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.9,
          ),
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            return GridItem(movie: searchResults[index]['show']);
          },
        ),
      ),
    );
  }

  Future<void> searchMovies() async {
    print('Inside Search Movies');
    final searchQuery = searchController.text;

    var url = Uri.parse('https://api.tvmaze.com/search/shows?q=$searchQuery');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Got Data');
      print(jsonDecode(response.body));
      setState(() {
        searchResults = jsonDecode(response.body);
      });
    } else {
      print('Failed');
    }
  }
}
