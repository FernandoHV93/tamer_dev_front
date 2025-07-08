import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/brand_storytelling_section_entity.dart';

class BrandStorytellingSection extends StatefulWidget {
  const BrandStorytellingSection({super.key});

  @override
  State<BrandStorytellingSection> createState() =>
      _BrandStorytellingSectionState();
}

class _BrandStorytellingSectionState extends State<BrandStorytellingSection> {
  String _centralStory = '';
  String _narrativeElements = '';
  String _humanRelatable = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .brandStorytellingSection;
    _centralStory = entity.centralStory;
    _narrativeElements = entity.narrativeElements;
    _humanRelatable = entity.humanRelatable;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = BrandStorytellingSectionEntity(
      centralStory: _centralStory,
      narrativeElements: _narrativeElements,
      humanRelatable: _humanRelatable,
    );
    provider.updateBrandStorytellingSection(entity);
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
                'assets/images/icons/book-marked.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Brand Storytelling',
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
          "Craft your brand's narrative",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('What is the central story of your brand?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _centralStory = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _centralStory,
              selection: TextSelection.collapsed(offset: _centralStory.length),
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
            'What narrative elements should always be present in your communications?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _narrativeElements = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _narrativeElements,
              selection:
                  TextSelection.collapsed(offset: _narrativeElements.length),
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
            'How can you use storytelling to make your brand more human and relatable?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _humanRelatable = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _humanRelatable,
              selection:
                  TextSelection.collapsed(offset: _humanRelatable.length),
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
