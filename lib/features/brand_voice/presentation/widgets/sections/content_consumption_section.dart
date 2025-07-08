import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../provider/deep_analysis_wizard_provider.dart';
import '../../../domain/entities/sections/content_consumption_section_entity.dart';

class ContentConsumptionSection extends StatefulWidget {
  const ContentConsumptionSection({super.key});

  @override
  State<ContentConsumptionSection> createState() =>
      _ContentConsumptionSectionState();
}

class _ContentConsumptionSectionState extends State<ContentConsumptionSection> {
  String _contentType = '';
  Map<String, bool> _channels = {
    'Instagram': false,
    'Blogs': false,
    'TikTok': false,
    'Newsletters': false,
    'Others': false,
  };

  @override
  void initState() {
    super.initState();
    final entity =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false)
            .wizardEntity
            .contentConsumptionSection;
    _contentType = entity.contentType;
    if (entity.channels.isNotEmpty) {
      _channels = {
        for (final ch in _channels.keys) ch: entity.channels.contains(ch),
      };
    }
  }

  void _saveToProvider() {
    final provider =
        Provider.of<DeepAnalysisWizardProvider>(context, listen: false);
    final selectedChannels =
        _channels.entries.where((e) => e.value).map((e) => e.key).toList();
    final entity = ContentConsumptionSectionEntity(
      contentType: _contentType,
      channels: selectedChannels,
    );
    provider.updateContentConsumptionSection(entity);
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
                'assets/images/icons/book-text.svg',
                width: 28,
                height: 28,
                colorFilter:
                    const ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Content Consumption',
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
          'Understand content preferences',
          style: TextStyle(color: Colors.white54, fontSize: 15),
        ),
        const SizedBox(height: 32),
        const Text('What type of content does your audience consume?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          onChanged: (val) {
            setState(() => _contentType = val);
            _saveToProvider();
          },
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: _contentType,
              selection: TextSelection.collapsed(offset: _contentType.length),
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
        const Text('Where does your audience consume this content?',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        ..._channels.keys.map((channel) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: CheckboxListTile(
                value: _channels[channel],
                onChanged: (val) {
                  setState(() => _channels[channel] = val ?? false);
                  _saveToProvider();
                },
                title: Text(channel,
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
      ],
    );
  }
}
