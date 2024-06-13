import 'package:app_filmes/widgets/trending_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../api/api.dart';
import '../models/movie.dart';
import '../widgets/movies_sliders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> allMoviesFuture;
  List<Movie> movies = [];
  List<Movie> filteredMovies = []; // Initialize as an empty list
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
    allMoviesFuture = getAllMovies();
  }

  Future<List<Movie>> getAllMovies() async {
    movies = await Api().getAllMovies();
    return movies;
  }

  void _movieFilter(String filter) {
    setState(() {
      searchQuery = filter;
      if (filter.isEmpty) {
        filteredMovies = [];
      } else {
        filteredMovies = movies
            .where((item) => item.title.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('FLIXFLIX'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Movies',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  _movieFilter(value);
                },
              ),
              const SizedBox(height: 32),
              searchQuery.isNotEmpty
                  ? filteredMovies.isNotEmpty
                  ? GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        movie.title,
                        style: GoogleFonts.aBeeZee(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              )
                  : const Center(child: Text('No movies found'))
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending Movies',
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    child: FutureBuilder(
                      future: trendingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return TrendingSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Top rated movies',
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    child: FutureBuilder(
                      future: topRatedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return MoviesSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Upcoming movies',
                    style: GoogleFonts.aBeeZee(fontSize: 25),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    child: FutureBuilder(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else if (snapshot.hasData) {
                          return MoviesSlider(snapshot: snapshot);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
