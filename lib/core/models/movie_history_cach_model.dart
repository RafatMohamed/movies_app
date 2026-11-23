import 'package:hive/hive.dart';

part 'movie_history_cach_model.g.dart';
@HiveType(typeId: 1)
class MovieCacheModel {
  @HiveField(0)
  final int id;


  @HiveField(1)
  final String image;

  @HiveField(2)
  final double rating;

  @HiveField(3)
  final DateTime openAt;

  MovieCacheModel({
    required this.id,
    required this.rating,
    required this.image,
    required this.openAt
  });
}