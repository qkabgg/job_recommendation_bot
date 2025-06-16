class JobRecommendation {
  final String title;
  final String company;
  final List<String> requiredSkills;
  final double matchPercentage;
  final String description;

  JobRecommendation({
    required this.title,
    required this.company,
    required this.requiredSkills,
    required this.matchPercentage,
    required this.description,
  });
}