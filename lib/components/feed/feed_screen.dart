import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_bloc.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_event.dart';
import 'package:spotlas_test/components/feed/bloc/feed_screen_state.dart';
import 'package:spotlas_test/components/recommendation/bloc/recommendation_view_bloc.dart';
import 'package:spotlas_test/components/recommendation/recommendation_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<FeedScreenBloc, FeedScreenState>(builder: (context, state) {
        if (state is FeedScreenLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        if (state is FeedScreenLoadedState) {
          return LazyLoadScrollView(
            onEndOfPage: () => BlocProvider.of<FeedScreenBloc>(context).add(LoadRecommendations(recommendations: state.recommendations, pageKey: state.pageKey + 1)),
            scrollOffset: 2000,
            child: CustomScrollView(
                slivers: state.recommendations
                    .map((recommendation) => BlocProvider(create: (context) => RecommendationViewBloc(recommendation), child: RecommendationView(recommendation: recommendation)))
                    .toList()),
          );
        }
        return Container();
      }),
    );
  }
}
