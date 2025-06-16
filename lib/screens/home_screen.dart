import 'package:flutter/material.dart';
import '../models/job_recommendation.dart';
import '../services/job_matching_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _skillsController = TextEditingController();
  final JobMatchingService _jobService = JobMatchingService();
  bool _isLoading = false;

  final List<String> _commonSkills = [
    'Python',
    'JavaScript',
    'React',
    'Flutter',
    'SQL',
    'Data Analysis',
    'Customer Service',
    'Project Management',
  ];

  void _addSkill(String skill) {
    final currentText = _skillsController.text;
    if (currentText.isEmpty) {
      _skillsController.text = skill;
    } else {
      _skillsController.text = '$currentText, $skill';
    }
  }

  Future<void> _findJobs() async {
    if (_skillsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your skills'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final skills = _skillsController.text.split(',').map((s) => s.trim()).toList();
      final recommendations = await _jobService.findMatchingJobs(skills);

      if (!mounted) return;

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => _buildResultsSheet(recommendations),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildResultsSheet(List<JobRecommendation> recommendations) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            _buildResultsHeader(recommendations),
            Expanded(
              child: _buildResultsList(recommendations, controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsHeader(List<JobRecommendation> recommendations) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 26),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Matching Jobs',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1F36),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${recommendations.length} jobs found based on your skills',
            style: const TextStyle(
              color: Color(0xFF757575),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List<JobRecommendation> recommendations, ScrollController controller) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.all(20),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final job = recommendations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 20),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        job.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1F36),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${(job.matchPercentage * 100).round()}% Match',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  job.company,
                  style: const TextStyle(
                    color: Color(0xFF757575),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  job.description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF1A1F36),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: job.requiredSkills.map((skill) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find Your Perfect Job',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1F36),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Tell us about your skills and experience',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF757575),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _skillsController,
                decoration: InputDecoration(
                  labelText: 'Your Skills & Experience',
                  hintText: 'E.g., I have 2 years of Python experience...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFFAFAFA),
                  contentPadding: const EdgeInsets.all(20),
                ),
                maxLines: 4,
                textInputAction: TextInputAction.done,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF1A1F36),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Common Skills',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1F36),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _commonSkills.map((skill) {
                  return InkWell(
                    onTap: () => _addSkill(skill),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _findJobs,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Find Matching Jobs',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }
}