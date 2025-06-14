class JobRecommendation {
  final String title;
  final double matchPercentage;
  final String description;

  JobRecommendation({
    required this.title,
    required this.matchPercentage,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'matchPercentage': matchPercentage,
      'description': description,
    };
  }

  factory JobRecommendation.fromJson(Map<String, dynamic> json) {
    return JobRecommendation(
      title: json['title'] as String,
      matchPercentage: json['matchPercentage'] as double,
      description: json['description'] as String,
    );
  }
}