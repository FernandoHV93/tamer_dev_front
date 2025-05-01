// Archivo: views/article_builder/components/seo_structure.dart

import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/section_header.dart';

class SeoStructure extends StatefulWidget {
  const SeoStructure({super.key});

  @override
  State<SeoStructure> createState() => _SeoStructureState();
}

class _SeoStructureState extends State<SeoStructure> {
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController hookBriefController = TextEditingController();

  String? selectedHookOption;

  String? conclusion = 'No';
  String? tables = 'No';
  String? h3 = 'No';
  String? lists = 'No';
  String? italics = 'No';
  String? quotes = 'No';
  String? keyTakeaways = 'No';
  String? faq = 'No';
  String? bold = 'No';
  String? stats = 'No';
  String? realPeopleOpinion = 'No';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'SEO',
              tooltip: 'Keywords will be used to generate relevant content.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: keywordsController,
              maxLength: 150,
              decoration: InputDecoration(
                labelText: 'Keywords to include in the text',
                border: const OutlineInputBorder(),
                suffixIcon: TextButton(
                  onPressed: () {
                    // Implement NLP keywords generation logic
                  },
                  child: const Text('NLP keywords generation'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SectionHeader(
              title: 'Structure',
              tooltip: 'Define the structure of the article.',
            ),
            const SizedBox(height: 16),
            const Text(
              'Introductory Hook Brief',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.hookOptions.map((hook) {
                final isSelected = selectedHookOption == hook;
                return ChoiceChip(
                  label: Text(hook),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedHookOption = hook;
                        hookBriefController.text =
                            AppConstants.hookPrompts[hook] ?? '';
                      } else {
                        selectedHookOption = null;
                        hookBriefController.clear();
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Introductory Hook Brief',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      selectedHookOption = null;
                      hookBriefController.clear();
                    });
                  },
                  icon: const Icon(Icons.clear, size: 16),
                  label: const Text('Clear'),
                )
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: hookBriefController,
              maxLength: 500,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText:
                    'Enter the type of hook for the article\'s opening sentence',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const SectionHeader(
              title: 'Content Options',
              tooltip: 'Enable or disable structural content features.',
            ),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              final int columnCount = (maxWidth ~/ 270).clamp(1, 3);
              final double itemWidth = (maxWidth / columnCount) - 16;

              return Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  _buildYesNoDropdown('Conclusion', conclusion,
                      (val) => setState(() => conclusion = val), itemWidth),
                  _buildYesNoDropdown('Tables', tables,
                      (val) => setState(() => tables = val), itemWidth),
                  _buildYesNoDropdown(
                      'H3', h3, (val) => setState(() => h3 = val), itemWidth),
                  _buildYesNoDropdown('Lists', lists,
                      (val) => setState(() => lists = val), itemWidth),
                  _buildYesNoDropdown('Italics', italics,
                      (val) => setState(() => italics = val), itemWidth),
                  _buildYesNoDropdown('Quotes', quotes,
                      (val) => setState(() => quotes = val), itemWidth),
                  _buildYesNoDropdown('Key Takeaways', keyTakeaways,
                      (val) => setState(() => keyTakeaways = val), itemWidth),
                  _buildYesNoDropdown('FAQ', faq,
                      (val) => setState(() => faq = val), itemWidth),
                  _buildYesNoDropdown('Bold', bold,
                      (val) => setState(() => bold = val), itemWidth),
                  _buildYesNoDropdown('Stats', stats,
                      (val) => setState(() => stats = val), itemWidth),
                  _buildYesNoDropdown(
                      'Real People Opinion',
                      realPeopleOpinion,
                      (val) => setState(() => realPeopleOpinion = val),
                      itemWidth),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildYesNoDropdown(
    String label,
    String? selected,
    void Function(String?) onChanged,
    double width,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: CustomDropdownTile(
        label: label,
        items: AppConstants.yesNoOptions,
        selectedValue: selected,
        onChanged: onChanged,
      ),
    );
  }
}
