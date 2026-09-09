class MovieParentalGuideModel {
  final String status;
  final String statusMessage;
  final ParentalGuidData data;
  final ParentalGuidMeta meta;

  MovieParentalGuideModel({
    required this.status,
    required this.statusMessage,
    required this.data,
    required this.meta,
  });

  factory MovieParentalGuideModel.fromJson(Map<String, dynamic> json) {
    return MovieParentalGuideModel(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      data: ParentalGuidData.fromJson(json['data'] ?? {}),
      meta: ParentalGuidMeta.fromJson(json['@meta'] ?? {}),
    );
  }
}

class ParentalGuidData {
  final int parentalGuideCount;
  final List<ParentalGuideItem> parentalGuides;

  ParentalGuidData({
    required this.parentalGuideCount,
    required this.parentalGuides,
  });

  factory ParentalGuidData.fromJson(Map<String, dynamic> json) {
    return ParentalGuidData(
      parentalGuideCount: json['parental_guide_count'] ?? 0,
      parentalGuides: (json['parental_guides'] as List? ?? [])
          .map(
            (item) => ParentalGuideItem.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class ParentalGuideItem {
  final String type;
  final String parentalGuideText;

  ParentalGuideItem({required this.type, required this.parentalGuideText});

  factory ParentalGuideItem.fromJson(Map<String, dynamic> json) {
    return ParentalGuideItem(
      type: json['type'] ?? '',
      parentalGuideText: json['parental_guide_text'] ?? '',
    );
  }
}

class ParentalGuidMeta {
  final int apiVersion;
  final String executionTime;

  ParentalGuidMeta({required this.apiVersion, required this.executionTime});

  factory ParentalGuidMeta.fromJson(Map<String, dynamic> json) {
    return ParentalGuidMeta(
      apiVersion: json['api_version'] ?? 0,
      executionTime: json['execution_time'] ?? '',
    );
  }
}
