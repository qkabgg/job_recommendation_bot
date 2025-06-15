import '../models/job_recommendation.dart';

class JobMatchingService {
  Future<List<JobRecommendation>> findMatchingJobs(List<String> skills) async {
    await Future.delayed(const Duration(seconds: 1));

    final jobs = [
      {
        'title': 'Data Analyst',
        'company': 'DataCorp',  // Added company
        'requiredSkills': ['python', 'excel', 'data'],
        'description': 'Analyze data and create reports',
      },
      {
        'title': 'Junior Developer',
        'company': 'TechCo',    // Added company
        'requiredSkills': ['python', 'java', 'javascript'],
        'description': 'Develop and maintain applications',
      },
      {
        'title': 'Customer Support Representative',
        'company': 'SupportInc', // Added company
        'requiredSkills': ['customer', 'service', 'excel'],
        'description': 'Handle customer inquiries and provide support',
      },
    ];

    final recommendations = <JobRecommendation>[];

    for (final job in jobs) {
      final requiredSkills = List<String>.from(job['requiredSkills'] as List);
      final matchingSkills = skills.where((skill) => 
        requiredSkills.contains(skill)).length;
      
      if (matchingSkills > 0) {
        final matchScore = matchingSkills.toDouble();
        final matchPercentage = matchingSkills / requiredSkills.length;
        recommendations.add(
          JobRecommendation(
            title: job['title'] as String,
            company: job['company'] as String,           // Added this
            requiredSkills: requiredSkills,             // Added this
            matchScore: matchScore,                     // Added this
            matchPercentage: matchPercentage,
            description: job['description'] as String,
          ),
        );
      }
    }

    recommendations.sort((a, b) => 
      b.matchPercentage.compareTo(a.matchPercentage));

    return recommendations;
  }
}