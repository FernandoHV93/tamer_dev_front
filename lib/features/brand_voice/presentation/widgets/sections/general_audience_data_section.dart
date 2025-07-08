import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/general_audience_data_section_entity.dart';
import 'custom_styled_dropdown.dart';

class GeneralAudienceDataSection extends StatefulWidget {
  const GeneralAudienceDataSection({super.key});

  @override
  State<GeneralAudienceDataSection> createState() =>
      _GeneralAudienceDataSectionState();
}

class _GeneralAudienceDataSectionState
    extends State<GeneralAudienceDataSection> {
  String? _selectedAge;
  Map<String, bool> _generations = {
    'Gen Z': false,
    'Millennials': false,
    'Gen X': false,
    'Baby Boomers': false,
  };
  String? _selectedGender;
  String? _selectedEducation;
  String _occupation = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .generalAudienceDataSection;
    _selectedAge = entity.averageAge;
    _selectedGender = entity.predominantGender;
    _selectedEducation = entity.educationLevel;
    _occupation = entity.occupation;
    // Map generations from entity
    if (entity.generations.isNotEmpty) {
      _generations = {
        for (final gen in _generations.keys)
          gen: entity.generations.contains(gen),
      };
    }
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final selectedGenerations =
        _generations.entries.where((e) => e.value).map((e) => e.key).toList();
    final entity = GeneralAudienceDataSectionEntity(
      averageAge: _selectedAge,
      generations: selectedGenerations,
      predominantGender: _selectedGender,
      educationLevel: _selectedEducation,
      occupation: _occupation,
    );
    provider.updateGeneralAudienceDataSection(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.groups, color: Colors.blueAccent, size: 32),
            SizedBox(width: 12),
            Text(
              'General Audience Data',
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
          "Let's understand who your audience is",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 24),
        // Age
        const Text('What is the average age of your audience?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        CustomStyledDropdown(
          value: _selectedAge,
          hint: 'Select an option',
          items: const ['18-24', '25-34', '35-44', '45-54', '55+'],
          onChanged: (val) {
            setState(() => _selectedAge = val);
            _saveToProvider();
          },
        ),
        const SizedBox(height: 18),
        // Generation
        const Text('Which generation does your ideal customer belong to?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        ..._generations.keys.map((gen) => CheckboxListTile(
              value: _generations[gen],
              onChanged: (val) {
                setState(() => _generations[gen] = val ?? false);
                _saveToProvider();
              },
              title: Text(gen,
                  style: const TextStyle(color: Colors.white, fontSize: 17)),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.blueAccent,
              contentPadding: EdgeInsets.zero,
            )),
        const SizedBox(height: 18),
        // Gender
        const Text('What is the predominant gender of your audience?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        CustomStyledDropdown(
          value: _selectedGender,
          hint: 'Select an option',
          items: const ['Male', 'Female', 'Other'],
          onChanged: (val) {
            setState(() => _selectedGender = val);
            _saveToProvider();
          },
        ),
        const SizedBox(height: 18),
        // Education
        const Text('What is the educational level of your audience?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        CustomStyledDropdown(
          value: _selectedEducation,
          hint: 'Select an option',
          items: const [
            'High School',
            'Bachelors Degree',
            'Masters Degree',
            'PhD',
            'Mixed'
          ],
          onChanged: (val) {
            setState(() => _selectedEducation = val);
            _saveToProvider();
          },
        ),
        const SizedBox(height: 18),
        // Occupation
        const Text('What is the primary occupation of your audience?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 2,
          onChanged: (val) {
            setState(() => _occupation = val);
            _saveToProvider();
          },
          decoration: InputDecoration(
            hintText: 'Type your answer here...',
            filled: true,
            fillColor: const Color(0xFF181A20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            hintStyle: const TextStyle(color: Colors.white54),
          ),
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}
