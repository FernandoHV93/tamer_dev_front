import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/tone_and_style_section_entity.dart';

class ToneAndStyleSection extends StatefulWidget {
  const ToneAndStyleSection({super.key});

  @override
  State<ToneAndStyleSection> createState() => _ToneAndStyleSectionState();
}

class _ToneAndStyleSectionState extends State<ToneAndStyleSection> {
  final List<String> _formalityOptions = [
    'Select an option',
    'Very Formal',
    'Formal',
    'Neutral',
    'Informal',
    'Very Informal',
  ];
  final List<String> _seriousnessOptions = [
    'Select an option',
    'Very Serious',
    'Serious',
    'Balanced',
    'Playful',
    'Very Playful',
  ];
  String? _selectedFormality;
  String? _selectedSeriousness;
  String _vocabulary = '';
  String _badNews = '';
  String _platformTone = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .toneAndStyleSection;
    _selectedFormality = entity.selectedFormality ?? _formalityOptions[0];
    _selectedSeriousness = entity.selectedSeriousness ?? _seriousnessOptions[0];
    _vocabulary = entity.vocabulary;
    _badNews = entity.badNews;
    _platformTone = entity.platformTone;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = ToneAndStyleSectionEntity(
      selectedFormality: _selectedFormality,
      selectedSeriousness: _selectedSeriousness,
      vocabulary: _vocabulary,
      badNews: _badNews,
      platformTone: _platformTone,
    );
    provider.updateToneAndStyleSection(entity);
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
                'assets/images/icons/speech.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Tone and Style',
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
          "Define your brand's voice characteristics",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('How formal or informal should your brand tone be?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF181A20),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedFormality,
            items: _formalityOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _selectedFormality = val);
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
        const Text('How serious or playful should your brand be?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF181A20),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedSeriousness,
            items: _seriousnessOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(
                  option,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _selectedSeriousness = val);
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
        const Text('What vocabulary best represents your brand?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _vocabulary = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _vocabulary,
              selection: TextSelection.collapsed(offset: _vocabulary.length),
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
            'How does your brand communicate bad news or sensitive topics?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _badNews = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _badNews,
              selection: TextSelection.collapsed(offset: _badNews.length),
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
        const Text('What is the appropriate tone for each platform or channel?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _platformTone = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _platformTone,
              selection: TextSelection.collapsed(offset: _platformTone.length),
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
