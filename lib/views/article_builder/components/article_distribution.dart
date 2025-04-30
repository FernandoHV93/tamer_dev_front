// Archivo: views/article_builder/components/article_distribution_section.dart

import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/section_header.dart';

class ArticleDistributionSection extends StatefulWidget {
  const ArticleDistributionSection({super.key});

  @override
  State<ArticleDistributionSection> createState() =>
      _ArticleDistributionSectionState();
}

class _ArticleDistributionSectionState
    extends State<ArticleDistributionSection> {
  String? sourceLinks = 'No';
  String? citations = 'No';
  String? internalLinking = 'None';
  String? externalLinking = 'None';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Connect to Web',
          tooltip: '',
        ),
        const SizedBox(height: 8),
        CustomDropdownTile(
          label: 'Source Links',
          selectedValue: sourceLinks,
          items: AppConstants.yesNoOptions,
          onChanged: (val) => setState(() => sourceLinks = val),
          note:
              'At the bottom of the article, a list of used sources will be displayed. You can choose the format in which these sources are presented.',
        ),
        const SizedBox(height: 12),
        CustomDropdownTile(
          label: 'Citations ✨',
          selectedValue: citations,
          items: AppConstants.yesNoOptions,
          onChanged: (val) => setState(() => citations = val),
          note:
              'At the end of the sentence, it includes a citation link to the source of the factual data utilized in crafting the content.',
        ),
        const SizedBox(height: 20),
        _buildLinkingCard(
          title: 'Internal Linking',
          value: internalLinking,
          onChanged: (val) => setState(() => internalLinking = val),
          note:
              'Automatically index your site and add links relevant to your content. Select a WordPress Site and our semantic search will find the best pages to link to within your article.',
        ),
        const SizedBox(height: 16),
        _buildLinkingCard(
          title: 'External Linking',
          value: externalLinking,
          onChanged: (val) => setState(() => externalLinking = val),
          note:
              'External Linking automatically integrates authoritative and relevant external links into your content, while also allowing you to manually specify desired links.',
        ),
        const SizedBox(height: 24),
        const SectionHeader(
          title: 'Syndication',
          tooltip:
              'Create marketing materials based on the article for various platforms.',
        ),
        const SizedBox(height: 10),
        const Text(
          'Select the platforms where you want to syndicate your article.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: AppConstants.syndicationOptions.entries.map((entry) {
            final platform = entry.key;
            final iconPath = entry.value;
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: AppConstants.selectedSyndication[platform],
                  onChanged: (val) {
                    setState(() {
                      AppConstants.selectedSyndication[platform] = val ?? false;
                    });
                  },
                ),
                Image.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 6),
                Text(platform),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLinkingCard({
    required String title,
    required String? value,
    required void Function(String?) onChanged,
    required String note,
  }) {
    return Card(
      elevation: 1,
      color: const Color(0xFFF9F9F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: title,
              tooltip: '',
            ),
            const SizedBox(height: 8),
            CustomDropdownTile(
              label: 'Select a WordPress Site',
              selectedValue: value,
              items: const ['None', 'Site 1', 'Site 2'],
              onChanged: onChanged,
              note: note,
            ),
          ],
        ),
      ),
    );
  }
}
