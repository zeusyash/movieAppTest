// home_screen.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_project/search_screen.dart';
import 'dart:convert';
import 'details_screen.dart';
import 'model/movie.dart';

class HometScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HometScreen> {
  List<dynamic> movies = [];
  Future<List<Movie>> MoviesFuture = getMovies();

  static Future<List<Movie>> getMovies() async {
    var url = Uri.parse("https://api.tvmaze.com/search/shows?q=all");
    final response = await http.get(url);
    final List body = json.decode(response.body);
    print('Response: $response');
    var list = body.map((e) {
      print("JSON data: $e");
      var movie = Movie.fromJson(e);
      print("Parsed Movie: $movie");
      return movie;
    }).toList();
    print('List: $list');
    return list;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchMovies();
  // }

  // Future<void> fetchMovies() async {
  //   var url = Uri.parse('https://api.tvmaze.com/search/shows?q=all');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     print('Got Data');
  //     print(jsonDecode(response.body));
  //     setState(() {
  //       movies = jsonDecode(response.body);
  //     });
  //   } else {
  //     print('Failed');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
        color: Colors.amber,
        child: Column(
          children: [
            Text('HomeScreen'),
            FutureBuilder<List<Movie>>(
              future: MoviesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // until data is fetched, show loader
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  // once data is fetched, display it on screen (call buildMovies())
                  final Movies = snapshot.data!;
                  return buildMovies(Movies);
                } else {
                  // if no data, show simple Text
                  return const Text("No data available");
                }
              },
            ),

            // ListView.builder(
            //   itemCount: movies.length,
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(movies[index]['show']['name']),
            //       subtitle: Text(movies[index]['show']['summary']),
            //       leading:
            //           Image.network(movies[index]['show']['image']['medium']),
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 DetailsScreen(movies[index]['show']),
            //           ),
            //         );
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget buildMovies(List<Movie> Movies) {
    // ListView Builder to show data in a list
    return ListView.builder(
      itemCount: Movies.length,
      itemBuilder: (context, index) {
        final Movie = Movies[index];
        return Container(
          color: Colors.grey.shade300,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.network(Movie.imageMedium!)),
              SizedBox(width: 10),
              Expanded(flex: 3, child: Text(Movie.title!)),
            ],
          ),
        );
      },
    );
  }
}
