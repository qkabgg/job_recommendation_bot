import 'package:flutter/material.dart';
import '../services/nlp_service.dart';
import '../services/job_matching_service.dart';
import '../widgets/skill_chip.dart';
import 'results_screen.dart';

class SkillInputScreen extends StatefulWidget {
  const SkillInputScreen({super.key});

  @override
  State<SkillInputScreen> createState() => _SkillInputScreenState();
}

class _SkillInputScreenState extends State<SkillInputScreen> {
  final TextEditingController _skillsController = TextEditingController();
  final NLPService _nlpService = NLPService();
  final JobMatchingService _jobMatchingService = JobMatchingService();
  bool _isProcessing = false;
  
  // Changed to final
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

  Future<void> _processInput() async {
    if (_skillsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your skills and experience'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final skills = await _nlpService.extractSkills(_skillsController.text);
      final recommendations = await _jobMatchingService.findMatchingJobs(skills);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(recommendations: recommendations),
        ),
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
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _addSkillToInput(String skill) {
    final currentText = _skillsController.text;
    final newText = currentText.isEmpty 
        ? skill 
        : '$currentText, $skill';
    _skillsController.text = newText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Find Your Perfect Job',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tell us about your skills and experience',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _skillsController,
                      decoration: const InputDecoration(
                        labelText: 'Your Skills & Experience',
                        hintText: 'E.g., I have 2 years of Python experience...',
                      ),
                      maxLines: 4,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Common Skills',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _commonSkills.map((skill) => 
                        SkillChip(
                          label: skill,
                          onTap: () => _addSkillToInput(skill),
                        ),
                      ).toList(),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isProcessing ? null : _processInput,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: _isProcessing
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
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
                    ),
                  ],
                ),
              ),
            ),
          ],
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