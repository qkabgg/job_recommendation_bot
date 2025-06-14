class UserInput {
  final String rawInput;
  final List<String> extractedSkills;

  UserInput({
    required this.rawInput,
    required this.extractedSkills,
  });

  Map<String, dynamic> toJson() {
    return {
      'rawInput': rawInput,
      'extractedSkills': extractedSkills,
    };
  }

  factory UserInput.fromJson(Map<String, dynamic> json) {
    return UserInput(
      rawInput: json['rawInput'] as String,
      extractedSkills: List<String>.from(json['extractedSkills']),
    );
  }
}