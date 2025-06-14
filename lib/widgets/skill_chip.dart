import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const SkillChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue.withAlpha(25), // Changed from withOpacity
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue.withAlpha(77), // Changed from withOpacity
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}