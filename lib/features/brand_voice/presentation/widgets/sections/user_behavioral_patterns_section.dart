import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/user_behavioral_patterns_section_entity.dart';

class UserBehavioralPatternsSection extends StatefulWidget {
  const UserBehavioralPatternsSection({super.key});

  @override
  State<UserBehavioralPatternsSection> createState() =>
      _UserBehavioralPatternsSectionState();
}

class _UserBehavioralPatternsSectionState
    extends State<UserBehavioralPatternsSection> {
  String _patterns = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .userBehavioralPatternsSection;
    _patterns = entity.patterns;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = UserBehavioralPatternsSectionEntity(
      patterns: _patterns,
    );
    provider.updateUserBehavioralPatternsSection(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF23262F),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/images/icons/messages-square.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'User Behavioral Patterns',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Analyze audience behavior',
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text("What are your audience's behavioral patterns?",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _patterns = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _patterns,
              selection: TextSelection.collapsed(offset: _patterns.length),
            ),
          ),
          decoration: InputDecoration(
            hintText: 'Type your answer here...',
            filled: true,
            fillColor: const Color(0xFF181A20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }
}
