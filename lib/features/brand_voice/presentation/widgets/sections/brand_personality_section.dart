import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/brand_personality_section_entity.dart';

class BrandPersonalitySection extends StatefulWidget {
  const BrandPersonalitySection({super.key});

  @override
  State<BrandPersonalitySection> createState() =>
      _BrandPersonalitySectionState();
}

class _BrandPersonalitySectionState extends State<BrandPersonalitySection> {
  final List<_PersonalityDropdown> _dropdowns = [
    _PersonalityDropdown('Is your brand young or mature?', ['Young', 'Mature']),
    _PersonalityDropdown(
        'Is it traditional or avant-garde?', ['Traditional', 'Avant-garde']),
    _PersonalityDropdown('Is it classic or modern?', ['Classic', 'Modern']),
    _PersonalityDropdown(
        'Is it introverted or extroverted?', ['Introverted', 'Extroverted']),
    _PersonalityDropdown(
        'Is it conservative or innovative?', ['Conservative', 'Innovative']),
    _PersonalityDropdown(
        'Is it reflective or playful?', ['Reflective', 'Playful']),
    _PersonalityDropdown(
        'Is it conventional or rebellious?', ['Conventional', 'Rebellious']),
    _PersonalityDropdown('Is it exclusive or open?', ['Exclusive', 'Open']),
  ];

  Map<int, String?> _selectedValues = {};
  String _brandAsPerson = '';
  String _brandAsFamous = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .brandPersonalitySection;
    _selectedValues = {
      for (var i = 0; i < _dropdowns.length; i++)
        i: entity.dropdownValues.length > i ? entity.dropdownValues[i] : null
    };
    _brandAsPerson = entity.brandAsPerson;
    _brandAsFamous = entity.brandAsFamous;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final dropdownValues =
        List<String?>.generate(_dropdowns.length, (i) => _selectedValues[i]);
    final entity = BrandPersonalitySectionEntity(
      dropdownValues: dropdownValues,
      brandAsPerson: _brandAsPerson,
      brandAsFamous: _brandAsFamous,
    );
    provider.updateBrandPersonalitySection(entity);
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
                'assets/images/icons/drama.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Brand Personality',
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
          "Define your brand's character traits",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        ...List.generate(
            _dropdowns.length,
            (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_dropdowns[i].label,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18)),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF181A20),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedValues[i],
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Select an option',
                                  style: TextStyle(color: Colors.white54)),
                            ),
                            ..._dropdowns[i]
                                .options
                                .map((option) => DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option,
                                          style: const TextStyle(
                                              color: Colors.white70)),
                                    )),
                          ],
                          onChanged: (val) {
                            setState(() => _selectedValues[i] = val);
                            _saveToProvider();
                          },
                          dropdownColor: const Color(0xFF23262F),
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Color(0xFF181A20),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
        const Text('If your brand were a person, how would you describe it?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _brandAsPerson = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _brandAsPerson,
              selection: TextSelection.collapsed(offset: _brandAsPerson.length),
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
        const Text('If your brand were a famous person, who would it be?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _brandAsFamous = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _brandAsFamous,
              selection: TextSelection.collapsed(offset: _brandAsFamous.length),
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

class _PersonalityDropdown {
  final String label;
  final List<String> options;
  _PersonalityDropdown(this.label, this.options);
}
