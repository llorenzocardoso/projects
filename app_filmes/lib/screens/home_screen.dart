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

  @override
  void initState(){
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
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
              Text(
                'Trending Movies',
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return TrendingSlider(snapshot: snapshot,);
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Top rated movies',
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: topRatedMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return MoviesSlider(snapshot: snapshot,);
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Upcoming movies',
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),
                      );
                    }else if(snapshot.hasData){
                      return MoviesSlider(snapshot: snapshot,);
                    }else{
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



