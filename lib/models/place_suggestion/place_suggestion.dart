class PlaceSuggestion {
  final String? description;
  final String? placeId;
  final String? mainText;
  final String? secondaryText;

  PlaceSuggestion({
    this.description,
    this.placeId,
    this.mainText,
    this.secondaryText,
  });

  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestion(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      mainText: json['mainText'] as String?,
      secondaryText: json['secondaryText'] as String?,
    );
  }
}