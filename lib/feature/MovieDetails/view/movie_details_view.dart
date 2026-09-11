import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utilities/package_utilies/get_it.dart';
import 'package:movies_app/feature/MovieDetails/view/widgets/movie_details_view_body.dart';
import 'package:movies_app/feature/MovieDetails/view_model/state_mangment.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final int movieID = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocProvider<MovieDetailsCubit>(
        create: (context) => getIt<MovieDetailsCubit>()..getMovieDetails(movieID: movieID),
        child:  SingleChildScrollView(
          physics: const ScrollPhysics(),
            child: MovieDetailsViewBody(
          movieID: movieID,
        )),
      ),
    );
  }
}
