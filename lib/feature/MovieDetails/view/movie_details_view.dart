import 'package:flutter/material.dart';
import 'package:movies_app/feature/MovieDetails/view/widgets/movie_details_view_body.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: MovieDetailsViewBody(),
      ),
    );
  }
}
