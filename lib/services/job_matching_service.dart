import '../models/job_recommendation.dart';

class JobMatchingService {
  Future<List<JobRecommendation>> findMatchingJobs(List<String> skills) async {
    await Future.delayed(const Duration(seconds: 1));

    final jobs = [
      {
        'title': 'Senior Flutter Developer',
        'company': 'TechCorp',
        'description': 'Looking for an experienced Flutter developer to join our team.',
        'requiredSkills': ['Flutter', 'Dart', 'REST API', 'Git'],
      },
      {
        'title': 'Full Stack Developer',
        'company': 'InnovateTech',
        'description': 'Seeking a Full Stack Developer with experience in React and Node.js.',
        'requiredSkills': ['React', 'Node.js', 'JavaScript', 'AWS'],
      },
      {
        'title': 'Data Scientist',
        'company': 'DataCo Analytics',
        'description': 'Join our data science team to work on exciting ML projects.',
        'requiredSkills': ['Python', 'Machine Learning', 'SQL', 'Statistics'],
      },
    ];

    final recommendations = <JobRecommendation>[];

    for (final job in jobs) {
      final requiredSkills = List<String>.from(job['requiredSkills'] as List);
      final matchingSkills = skills.where((skill) =>
        requiredSkills.any((req) => req.toLowerCase().contains(skill.toLowerCase()))).length;
      
      if (matchingSkills > 0) {
        final matchPercentage = matchingSkills / requiredSkills.length;
        recommendations.add(
          JobRecommendation(
            title: job['title'] as String,
            company: job['company'] as String,
            requiredSkills: requiredSkills,
            matchPercentage: matchPercentage,
            description: job['description'] as String,
          ),
        );
      }
    }

    recommendations.sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));
    return recommendations;
  }
}