class NLPService {
  // This is a basic implementation. We'll enhance it later with actual NLP processing
  Future<List<String>> extractSkills(String input) async {
    // Simulate processing delay
    await Future.delayed(const Duration(seconds: 1));

    // Basic word extraction (to be replaced with proper NLP)
    final words = input.toLowerCase().split(' ');
    final skills = words.where((word) => _isSkill(word)).toList();
    
    return skills;
  }

  bool _isSkill(String word) {
    // Basic skill dictionary (to be expanded)
    final skillsList = [
      'python','java','javascript','flutter','react','angular','data','entry','excel','word','customer','service',
    ];

    return skillsList.contains(word);
  }
}