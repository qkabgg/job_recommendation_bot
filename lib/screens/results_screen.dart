import 'package:flutter/material.dart';
import '../models/job_recommendation.dart';

class ResultsScreen extends StatelessWidget {
  final List<JobRecommendation> recommendations;

  const ResultsScreen({
    super.key,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('Recommended Jobs'),
              centerTitle: true,
            ),
            if (recommendations.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No matching jobs found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final job = recommendations[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: JobCard(job: job),
                    );
                  },
                  childCount: recommendations.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobRecommendation job;

  const JobCard({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getMatchColor(job.matchPercentage),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(job.matchPercentage * 100).round()}% Match',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement job details view
              },
              child: const Text('View Details'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMatchColor(double matchPercentage) {
    if (matchPercentage >= 0.8) return Colors.green;
    if (matchPercentage >= 0.6) return Colors.blue;
    if (matchPercentage >= 0.4) return Colors.orange;
    return Colors.red;
  }
}