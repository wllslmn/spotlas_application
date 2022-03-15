import 'package:equatable/equatable.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';

abstract class FeedScreenEvent extends Equatable {
  @override
  String toString() => "$runtimeType {}";
}

class LoadRecommendations extends FeedScreenEvent {
  final List<Recommendation> recommendations;
  final int pageKey;

  LoadRecommendations({required this.recommendations, required this.pageKey});

  @override
  String toString() => '$runtimeType {}';

  @override
  List<Object?> get props => [recommendations, pageKey];
}