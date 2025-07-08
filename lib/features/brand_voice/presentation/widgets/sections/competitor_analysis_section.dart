import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/competitor_analysis_section_entity.dart';

class CompetitorAnalysisSection extends StatefulWidget {
  const CompetitorAnalysisSection({super.key});

  @override
  State<CompetitorAnalysisSection> createState() =>
      _CompetitorAnalysisSectionState();
}

class _CompetitorAnalysisSectionState extends State<CompetitorAnalysisSection> {
  String _communication = '';
  String? _selectedTone;
  final List<String> _toneOptions = [
    'Select an option',
    'Formal',
    'Casual',
    'Friendly',
    'Authoritative',
    'Playful',
    'Other',
  ];
  Map<String, bool> _personality = {
    'Reliable': false,
    'Innovative': false,
    'Fun': false,
  };
  String _brandDifference = '';
  String _brandPerception = '';
  String _voiceStrategy = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .competitorAnalysisSection;
    _communication = entity.communication;
    _selectedTone =
        entity.selectedTone.isNotEmpty ? entity.selectedTone : _toneOptions[0];
    if (entity.personality.isNotEmpty) {
      _personality = {
        for (final key in _personality.keys)
          key: entity.personality.contains(key),
      };
    }
    _brandDifference = entity.brandDifference;
    _brandPerception = entity.brandPerception;
    _voiceStrategy = entity.voiceStrategy;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final selectedPersonality =
        _personality.entries.where((e) => e.value).map((e) => e.key).toList();
    final entity = CompetitorAnalysisSectionEntity(
      communication: _communication,
      selectedTone: _selectedTone ?? '',
      personality: selectedPersonality,
      brandDifference: _brandDifference,
      brandPerception: _brandPerception,
      voiceStrategy: _voiceStrategy,
    );
    provider.updateCompetitorAnalysisSection(entity);
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
                'assets/images/icons/chart-area.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Competitor Analysis',
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
          'Analyze your competition',
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('How do your main competitors communicate?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _communication = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _communication,
              selection: TextSelection.collapsed(offset: _communication.length),
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
        const SizedBox(height: 24),
        const Text('What tone do your competitors use?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: const Color(0xFF181A20),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedTone,
            items: _toneOptions.map((tone) {
              return DropdownMenuItem<String>(
                value: tone,
                child: Text(
                  tone,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _selectedTone = val);
              _saveToProvider();
            },
            dropdownColor: const Color(0xFF23262F),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFF181A20),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
        const SizedBox(height: 24),
        const Text('What type of personality do your competitors project?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        ..._personality.keys.map((type) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CheckboxListTile(
                value: _personality[type],
                onChanged: (val) {
                  setState(() => _personality[type] = val ?? false);
                  _saveToProvider();
                },
                title: Text(type,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.blueAccent,
                checkColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                dense: true,
                side: const BorderSide(color: Colors.white54, width: 1.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
            )),
        const SizedBox(height: 24),
        const Text('What makes your brand different from others?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _brandDifference = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _brandDifference,
              selection:
                  TextSelection.collapsed(offset: _brandDifference.length),
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
        const SizedBox(height: 24),
        const Text(
            'How do you want your brand to be perceived in comparison to competitors?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _brandPerception = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _brandPerception,
              selection:
                  TextSelection.collapsed(offset: _brandPerception.length),
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
        const SizedBox(height: 24),
        const Text(
            'Should you adopt a similar voice or differentiate radically? Why?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _voiceStrategy = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _voiceStrategy,
              selection: TextSelection.collapsed(offset: _voiceStrategy.length),
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
