import 'package:spotlas_test/stores/models/recommendation/tag.dart';
import 'dart:convert';

Recommendation recommendationFromJson(String str) => Recommendation.fromJson(json.decode(str));
String recommendationToJson(Recommendation data) => json.encode(data.toJson());

class Recommendation {
  final String id;
  final DateTime createdAt;
  final String authorId;
  final String placeId;
  final String description;
  final String defaultPhotoUrl;
  final String placeholderLogo;
  final List<Tag> recommendationTags;
  final String authorUsername;
  final String authorFullName;
  final String placeName;
  final String placeLocationName;
  final String placeLocationNameO;
  final String placeLogoUrl;
  final String authorPhotoUrl;
  final List<String> photoUrls;
  final bool isLiked;
  final bool isBookmarked;

  Recommendation({
    required this.id,
    required this.createdAt,
    required this.authorId,
    required this.placeId,
    required this.description,
    required this.defaultPhotoUrl,
    required this.placeholderLogo,
    required this.recommendationTags,
    required this.authorUsername,
    required this.authorFullName,
    required this.placeName,
    required this.placeLocationName,
    required this.placeLocationNameO,
    required this.placeLogoUrl,
    required this.authorPhotoUrl,
    required this.photoUrls,
    required this.isLiked,
    required this.isBookmarked
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
    id: json["id"] ?? "",
    createdAt: DateTime.parse(json["createdAt"]),
    authorId: json["authorId"] ?? "",
    placeId: json["placeId"] ?? "",
    description: json["description"] ?? "",
    defaultPhotoUrl: json["defaultPhotoUrl"] ?? "",
    placeholderLogo: json["placeholder_logo"] ?? "",
    recommendationTags: List<Tag>.from(json["tags_"] != null ? json["tags_"].map((x) => Tag.fromJson(x)) : []),
    authorUsername: json["authorUsername"] ?? "",
    authorFullName: json["authorFullName"] ?? "",
    placeName: json["placeName"] ?? "",
    placeLocationName: json["placeLocationName"] ?? "",
    placeLocationNameO: json["placeLocationNameO"]?? "",
    placeLogoUrl: json["placeLogoUrl"] ?? "",
    isLiked: json["isLiked"] ?? false,
    isBookmarked: json["isBookmarked"] ?? false,
    authorPhotoUrl: json["authorPhotoUrl"] ?? "",
    photoUrls: List<String>.from(json["photoUrls"] != null ? json["photoUrls"].map((x) => x) : []),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt.toIso8601String(),
    "authorId": authorId,
    "placeId": placeId,
    "description": description,
    "defaultPhotoUrl": defaultPhotoUrl,
    "placeholder_logo": placeholderLogo,
    "tags_": List<Tag>.from(recommendationTags.map((x) => x.toJson())),
    "authorUsername": authorUsername,
    "authorFullName": authorFullName,
    "placeName": placeName,
    "placeLocationName": placeLocationName,
    "placeLocationNameO": placeLocationNameO,
    "placeLogoUrl": placeLogoUrl,
    "isLiked": isLiked,
    "isBookmarked": isBookmarked,
    "authorPhotoUrl": authorPhotoUrl,
    "photoUrls": List<String>.from(photoUrls.map((x) => x)),
  };
}










