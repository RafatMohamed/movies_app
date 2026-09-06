class MovieSuggestionModel {
  final String status;
  final String statusMessage;
  final MovieSuggestionData data;
  final MovieSuggestionMeta meta;

  MovieSuggestionModel({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  factory MovieSuggestionModel.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionModel(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      data: MovieSuggestionData.fromJson(json['data'] ?? {}),
      meta: MovieSuggestionMeta.fromJson(json['@meta'] ?? {}),
    );
  }
}

class MovieSuggestionData {
  final int movieCount;
  final List<MovieSuggestionItem> movies;

  MovieSuggestionData({
    required this.movieCount,
    required this.movies,
  });

  factory MovieSuggestionData.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionData(
      movieCount: json['movie_count'] ?? 0,
      movies: (json['movies'] as List? ?? [])
          .map(
            (movie) => MovieSuggestionItem.fromJson(
          movie as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}

class MovieSuggestionItem {
  final int id;
  final String url;
  final String imdbCode;
  final String title;
  final String titleEnglish;
  final String titleLong;
  final String slug;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String summary;
  final String descriptionFull;
  final String synopsis;
  final String ytTrailerCode;
  final String language;
  final String mpaRating;

  final String backgroundImage;
  final String backgroundImageOriginal;
  final String smallCoverImage;
  final String mediumCoverImage;

  final String state;

  final List<MovieSuggestionTorrent> torrents;

  final String dateUploaded;
  final int dateUploadedUnix;

  MovieSuggestionItem({
    required this.id,
    required this.url,
    required this.imdbCode,
    required this.title,
    required this.titleEnglish,
    required this.titleLong,
    required this.slug,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.summary,
    required this.descriptionFull,
    required this.synopsis,
    required this.ytTrailerCode,
    required this.language,
    required this.mpaRating,
    required this.backgroundImage,
    required this.backgroundImageOriginal,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.state,
    required this.torrents,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieSuggestionItem.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionItem(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      imdbCode: json['imdb_code'] ?? '',
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? '',
      titleLong: json['title_long'] ?? '',
      slug: json['slug'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0).toDouble(),
      runtime: json['runtime'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      summary: json['summary'] ?? '',
      descriptionFull: json['description_full'] ?? '',
      synopsis: json['synopsis'] ?? '',
      ytTrailerCode: json['yt_trailer_code'] ?? '',
      language: json['language'] ?? '',
      mpaRating: json['mpa_rating'] ?? '',
      backgroundImage: json['background_image'] ?? '',
      backgroundImageOriginal:
      json['background_image_original'] ?? '',
      smallCoverImage: json['small_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      state: json['state'] ?? '',
      torrents: (json['torrents'] as List? ?? [])
          .map(
            (torrent) => MovieSuggestionTorrent.fromJson(
          torrent as Map<String, dynamic>,
        ),
      )
          .toList(),
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }
}

class MovieSuggestionTorrent {
  final String url;
  final String hash;
  final String quality;
  final String isRepack;
  final String videoCodec;
  final String bitDepth;
  final String audioChannels;
  final int seeds;
  final int peers;
  final String size;
  final int sizeBytes;
  final String dateUploaded;
  final int dateUploadedUnix;

  MovieSuggestionTorrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.isRepack,
    required this.videoCodec,
    required this.bitDepth,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory MovieSuggestionTorrent.fromJson(
      Map<String, dynamic> json,
      ) {
    return MovieSuggestionTorrent(
      url: json['url'] ?? '',
      hash: json['hash'] ?? '',
      quality: json['quality'] ?? '',
      isRepack: json['is_repack'] ?? '',
      videoCodec: json['video_codec'] ?? '',
      bitDepth: json['bit_depth'] ?? '',
      audioChannels: json['audio_channels'] ?? '',
      seeds: json['seeds'] ?? 0,
      peers: json['peers'] ?? 0,
      size: json['size'] ?? '',
      sizeBytes: json['size_bytes'] ?? 0,
      dateUploaded: json['date_uploaded'] ?? '',
      dateUploadedUnix: json['date_uploaded_unix'] ?? 0,
    );
  }
}

class MovieSuggestionMeta {
  final int apiVersion;
  final String executionTime;

  MovieSuggestionMeta({
    required this.apiVersion,
    required this.executionTime,
  });

  factory MovieSuggestionMeta.fromJson(Map<String, dynamic> json) {
    return MovieSuggestionMeta(
      apiVersion: json['api_version'] ?? 0,
      executionTime: json['execution_time'] ?? '',
    );
  }
}