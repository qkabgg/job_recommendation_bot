import '../models/job_recommendation.dart';

class JobMatchingService {
  // This is a basic implementation. We'll enhance it later with better matching logic
  Future<List<JobRecommendation>> findMatchingJobs(List<String> skills) async {
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock job database (to be replaced with actual data)
    final jobs = [
      {
        'title': 'Data Analyst',
        'requiredSkills': ['python', 'excel', 'data'],
        'description': 'Analyze data and create reports',
      },
      {
        'title': 'Junior Developer',
        'requiredSkills': ['python', 'java', 'javascript'],
        'description': 'Develop and maintain applications',
      },
      {
        'title': 'Customer Support Representative',
        'requiredSkills': ['customer', 'service', 'excel'],
        'description': 'Handle customer inquiries and provide support',
      },
    ];

    final recommendations = <JobRecommendation>[];

    for (final job in jobs) {
      final requiredSkills = job['requiredSkills'] as List<String>;
      final matchingSkills = skills.where((skill) => 
        requiredSkills.contains(skill)).length;
      
      if (matchingSkills > 0) {
        final matchPercentage = matchingSkills / requiredSkills.length;
        recommendations.add(
          JobRecommendation(
            title: job['title'] as String,
            matchPercentage: matchPercentage,
            description: job['description'] as String,
          ),
        );
      }
    }

    // Sort by match percentage descending
    recommendations.sort((a, b) => 
      b.matchPercentage.compareTo(a.matchPercentage));

    return recommendations;
  }
}