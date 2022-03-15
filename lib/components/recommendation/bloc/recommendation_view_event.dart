import 'package:equatable/equatable.dart';

abstract class RecommendationViewEvent extends Equatable {
  @override
  String toString() => "$runtimeType {}";
}

class LikeRecommendation extends RecommendationViewEvent {
  final bool isLiked;

  LikeRecommendation({required this.isLiked});

  @override
  String toString() => '$runtimeType {}';

  @override
  List<Object?> get props => [isLiked];
}

class BookmarkRecommendation extends RecommendationViewEvent {
  final bool isBookmarked;

  BookmarkRecommendation({required this.isBookmarked});

  @override
  String toString() => '$runtimeType {}';

  @override
  List<Object?> get props => [isBookmarked];
}