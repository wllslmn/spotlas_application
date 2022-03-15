import 'package:equatable/equatable.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';

class RecommendationViewState extends Equatable {
  final Recommendation recommendation;
  final bool isLiked;
  final bool isBookmarked;
  const RecommendationViewState({required this.recommendation, required this.isLiked, required this.isBookmarked});

  @override
  List<Object?> get props => [recommendation, isLiked, isBookmarked];
}
