import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/brand_perception_section_entity.dart';

class BrandPerceptionSection extends StatefulWidget {
  const BrandPerceptionSection({super.key});

  @override
  State<BrandPerceptionSection> createState() => _BrandPerceptionSectionState();
}

class _BrandPerceptionSectionState extends State<BrandPerceptionSection> {
  String _object = '';
  String _slogan = '';
  String _feeling = '';
  String _afterPurchase = '';

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .brandPerceptionSection;
    _object = entity.object;
    _slogan = entity.slogan;
    _feeling = entity.feeling;
    _afterPurchase = entity.afterPurchase;
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final entity = BrandPerceptionSectionEntity(
      object: _object,
      slogan: _slogan,
      feeling: _feeling,
      afterPurchase: _afterPurchase,
    );
    provider.updateBrandPerceptionSection(entity);
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
                'assets/images/icons/eye.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Brand Perception',
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
          "Visualize your brand's impact",
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('If your brand were an object, what would it be and why?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _object = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _object,
              selection: TextSelection.collapsed(offset: _object.length),
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
            'If your brand had an internal slogan or mantra, what would it be?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _slogan = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _slogan,
              selection: TextSelection.collapsed(offset: _slogan.length),
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
            'How do you want your customers to feel after interacting with your content?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _feeling = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _feeling,
              selection: TextSelection.collapsed(offset: _feeling.length),
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
            'What do you want customers to think about your brand after making a purchase?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _afterPurchase = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _afterPurchase,
              selection: TextSelection.collapsed(offset: _afterPurchase.length),
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
