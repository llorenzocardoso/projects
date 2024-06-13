import 'package:app_filmes/constants.dart';
import 'package:app_filmes/models/movie.dart';
import 'package:app_filmes/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {

  const DetailsScreen({
    super.key,
    required this.movie
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const BackBtn(),
          backgroundColor: Colors.black,
          expandedHeight: 500,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                '${Constants.imagePath}${movie.posterPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(children: [
                Text(
                  'Overview',
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  movie.overview,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Release Date: ',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              movie.releaseDate,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                                'Rating',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                                '${movie.voteAverage.toStringAsFixed(1)}/10',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
              ),
          ),
        ),
      ],
      ),
    );
  }
}