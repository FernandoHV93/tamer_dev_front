import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/motivations_and_values_section_entity.dart';

class MotivationsAndValuesSection extends StatefulWidget {
  const MotivationsAndValuesSection({super.key});

  @override
  State<MotivationsAndValuesSection> createState() =>
      _MotivationsAndValuesSectionState();
}

class _MotivationsAndValuesSectionState
    extends State<MotivationsAndValuesSection> {
  String _motivation = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .motivationsAndValuesSection;
    _motivation = entity.motivation;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = MotivationsAndValuesSectionEntity(
      motivation: _motivation,
    );
    provider.updateMotivationsAndValuesSection(entity);
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
                'assets/images/icons/heart.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Motivations and Values',
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
          'Explore what drives your audience',
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('What motivates your audience to make purchasing decisions?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _motivation = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _motivation,
              selection: TextSelection.collapsed(offset: _motivation.length),
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
