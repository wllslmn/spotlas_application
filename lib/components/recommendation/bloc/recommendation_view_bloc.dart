import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_event.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_state.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';

class RecommendationViewBloc extends Bloc<RecommendationViewEvent, RecommendationViewState> {
  final Recommendation recommendation;

  RecommendationViewBloc(this.recommendation) : super(RecommendationViewState(recommendation: recommendation, isLiked: recommendation.isLiked, isBookmarked: recommendation.isBookmarked)){
    on<LikeRecommendation>((event, emit) async {
      emit(RecommendationViewState(recommendation: state.recommendation, isLiked: !event.isLiked, isBookmarked: state.isBookmarked));
    });
    on<BookmarkRecommendation>((event, emit) async {
      emit(RecommendationViewState(recommendation: state.recommendation, isBookmarked: !event.isBookmarked, isLiked: state.isLiked));
    });
  }
}