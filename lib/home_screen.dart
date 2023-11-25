// home_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_project/search_screen.dart';
import 'dart:convert';
import 'grid_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    var url = Uri.parse('https://api.tvmaze.com/search/shows?q=all');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('Got Data');
      print(jsonDecode(response.body));
      setState(() {
        movies = jsonDecode(response.body);
      });
    } else {
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(229, 9, 20, 1),
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.9,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GridItem(movie: movies[index]['show']);
          },
        ),
      ),
    );
  }
}
