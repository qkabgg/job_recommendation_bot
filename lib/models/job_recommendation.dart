class JobRecommendation {
  final String title;
  final String company;
  final List<String> requiredSkills;
  final double matchScore;
  final double matchPercentage;
  final String description;

  JobRecommendation({
    required this.title,
    required this.company,
    required this.requiredSkills,
    required this.matchScore,
    required this.matchPercentage,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'requiredSkills': requiredSkills,
      'matchScore': matchScore,
      'matchPercentage': matchPercentage,
      'description': description,
    };
  }

  factory JobRecommendation.fromJson(Map<String, dynamic> json) {
    return JobRecommendation(
      title: json['title'] as String,
      company: json['company'] as String,
      requiredSkills: (json['requiredSkills'] as List).cast<String>(),
      matchScore: json['matchScore'] as double,
      matchPercentage: json['matchPercentage'] as double,
      description: json['description'] as String,
    );
  }
}