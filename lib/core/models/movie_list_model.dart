class MovieListModel {
  final String status;
  final String statusMessage;
  final MovieListDataModel data;
  final MetaModel meta;

  MovieListModel({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  factory MovieListModel.fromJson(Map<String, dynamic> json) {
    return MovieListModel(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      data: MovieListDataModel.fromJson(json['data'] ?? {}),
      meta: MetaModel.fromJson(json['@meta'] ?? {}),
    );
  }
}

class MovieListDataModel {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<MovieListItemModel> movies;

  MovieListDataModel({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MovieListDataModel.fromJson(Map<String, dynamic> json) {
    return MovieListDataModel(
      movieCount: json['movie_count'] ?? 0,
      limit: json['limit'] ?? 0,
      pageNumber: json['page_number'] ?? 0,
      movies: (json['movies'] as List? ?? [])
          .map((e) => MovieListItemModel.fromJson(e))
          .toList(),
    );
  }
}

class MovieListItemModel {
  final int id;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String language;
  final String mpaRating;
  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;
  final String largeCoverImage;

  MovieListItemModel({
    required this.id,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
  });

  factory MovieListItemModel.fromJson(Map<String, dynamic> json) {
    return MovieListItemModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal: json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
    );
  }
}

class MetaModel {
  final int apiVersion;
  final String executionTime;

  MetaModel({required this.apiVersion, required this.executionTime});

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      apiVersion: json['api_version'] ?? 0,
      executionTime: json['execution_time'] ?? '',
    );
  }
}
