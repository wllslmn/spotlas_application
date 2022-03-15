import 'package:equatable/equatable.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';

class FeedScreenState extends Equatable {

  const FeedScreenState();

  @override
  List<Object?> get props => [];
}

class FeedScreenLoadingState extends FeedScreenState {

  const FeedScreenLoadingState();

  @override
  List<Object?> get props => [];
}

class FeedScreenLoadedState extends FeedScreenState {
  final List<Recommendation> recommendations;
  final int pageKey;

  const FeedScreenLoadedState({required this.recommendations, required this.pageKey});

  @override
  List<Object?> get props => [recommendations, pageKey];
}