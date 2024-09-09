
import 'package:equatable/equatable.dart';

class WatchlistModel extends Equatable {
  final String? id;
  final String? backdropPath;
  final String? releaseDate;
  final String? originalTitle;
  final String? overview;

  const WatchlistModel(
      {required this.id,
      required this.backdropPath,
      required this.originalTitle,
      required this.releaseDate,
      required this.overview});

  @override
  // TODO: implement props
  List<Object?> get props => [id];

// factory
  static WatchlistModel fromJson(Map<String , dynamic> json) {
    return WatchlistModel(
        id: json['id'],
        backdropPath: json['backdropPath'],
        originalTitle: json['originalTitle'],
        releaseDate: json['releaseDate'],
        overview: json['overview']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "backdropPath": backdropPath,
      "originalTitle": originalTitle,
      "releaseDate": releaseDate,
      "overview": overview,
    };
  }
}
