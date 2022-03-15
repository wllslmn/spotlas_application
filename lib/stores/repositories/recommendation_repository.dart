import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotlas_test/stores/models/recommendation/recommendation.dart';

class RecommendationRepository {
  Future<List<Recommendation>> getRecommendations(final int page) async {
    List<Recommendation> recommendations;
    final response = await get(Uri.parse("http://161.35.162.216:1210/interview/home/reel?lat=51.5&lon=-0.17&page=$page"));
    recommendations = (json.decode(response.body) as List).map((i) =>
        Recommendation.fromJson(i)).toList();
    return recommendations;
  }
}