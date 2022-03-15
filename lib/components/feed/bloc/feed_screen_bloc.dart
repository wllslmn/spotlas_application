import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_event.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_state.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';
import 'package:spotlas_test/stores/repositories/recommendation_repository.dart';

class FeedScreenBloc extends Bloc<FeedScreenEvent, FeedScreenState> {
  final RecommendationRepository _recommendationRepository;

  FeedScreenBloc(this._recommendationRepository) : super(const FeedScreenLoadingState()){
    on<LoadRecommendations>((event, emit) async {
      final List<Recommendation> recommendations = await _recommendationRepository.getRecommendations(event.pageKey);
      emit(FeedScreenLoadedState(recommendations: List<Recommendation>.from(event.recommendations).followedBy(recommendations).toList(), pageKey: event.pageKey));
    });
  }
}