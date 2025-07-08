import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/brand_archetypes_section_entity.dart';

class BrandArchetypesSection extends StatefulWidget {
  const BrandArchetypesSection({super.key});

  @override
  State<BrandArchetypesSection> createState() => _BrandArchetypesSectionState();
}

class _BrandArchetypesSectionState extends State<BrandArchetypesSection> {
  final List<String> _archetypeOptions = [
    'Select an option',
    'The Innocent',
    'The Explorer',
    'The Sage',
    'The Hero',
    'The Outlaw',
    'The Magician',
    'The Regular Guy/Gal',
    'The Lover',
    'The Jester',
    'The Caregiver',
    'The Creator',
    'The Ruler',
  ];
  String? _selectedArchetype;
  String _motivation = '';
  String _emotionalConnection = '';
  String _emotionsToEvoke = '';
  String _combineArchetypes = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .brandArchetypesSection;
    _selectedArchetype = entity.selectedArchetype ?? _archetypeOptions[0];
    _motivation = entity.motivation;
    _emotionalConnection = entity.emotionalConnection;
    _emotionsToEvoke = entity.emotionsToEvoke;
    _combineArchetypes = entity.combineArchetypes;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = BrandArchetypesSectionEntity(
      selectedArchetype: _selectedArchetype,
      motivation: _motivation,
      emotionalConnection: _emotionalConnection,
      emotionsToEvoke: _emotionsToEvoke,
      combineArchetypes: _combineArchetypes,
    );
    provider.updateBrandArchetypesSection(entity);
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
                'assets/images/icons/compass.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Brand Archetypes',
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
          "Define your brand's archetypal identity",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('Which brand archetype best reflects your purpose?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF181A20),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedArchetype,
            items: _archetypeOptions.map((archetype) {
              return DropdownMenuItem<String>(
                value: archetype,
                child: Text(
                  archetype,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              );
            }).toList(),
            onChanged: (val) {
              setState(() => _selectedArchetype = val);
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
        const Text(
            'What is the main motivation of the chosen archetype, and how does it align with your brand?',
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
        const SizedBox(height: 24),
        const Text(
            'How can you use this archetype to connect emotionally with your audience?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _emotionalConnection = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _emotionalConnection,
              selection:
                  TextSelection.collapsed(offset: _emotionalConnection.length),
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
        const Text('What emotions do you want your brand to evoke?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _emotionsToEvoke = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _emotionsToEvoke,
              selection:
                  TextSelection.collapsed(offset: _emotionsToEvoke.length),
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
            'Can you combine archetypes to make your brand voice more unique? Which ones?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _combineArchetypes = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _combineArchetypes,
              selection:
                  TextSelection.collapsed(offset: _combineArchetypes.length),
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
