import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/custom_dropdown.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/section_header.dart';

class SeoStructure extends StatelessWidget {
  const SeoStructure({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleBuilderProvider>();
    final seo = provider.articleBuilderEntity.articleSEO;
    final structure = provider.articleBuilderEntity.articleStructure;

    return Card(
      elevation: 2,
      color: const Color.fromARGB(255, 41, 41, 41),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Seo',
              tooltip: 'Keywords will be used to generate relevant content.',
            ),
            const SizedBox(height: 12),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLength: 150,
              decoration: InputDecoration(
                labelText: 'Keywords to include in the text',
                labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final keyword = provider
                        .articleBuilderEntity.articleSEO.keywords
                        .join(', ');
                    if (keyword.isNotEmpty) {
                      provider.addKeyword(keyword);
                    }
                  },
                ),
              ),
              onSubmitted: (val) {
                final keyword = val.trim();
                if (keyword.isNotEmpty) {
                  provider.addKeyword(keyword);
                }
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: seo.keywords.map((keyword) {
                return Chip(
                  label: Text(keyword),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    provider.removeKeyword(keyword);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const SectionHeader(
              title: 'Structure',
              tooltip: 'Define the structure of the article.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Introductory Hook Brief',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.hookOptions.map((hook) {
                final isSelected = structure.typeOfHook == hook;
                return ChoiceChip(
                  label: Text(hook),
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: const Color.fromARGB(255, 67, 67, 67),
                  checkmarkColor: Colors.white,
                  selectedColor: const Color.fromARGB(234, 4, 73, 129),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      provider.updateTypeOfHook(hook);
                      provider.updateIntroductoryHookBrief(
                          AppConstants.hookPrompts[hook] ?? '');
                    } else {
                      provider.updateTypeOfHook("");
                      provider.updateIntroductoryHookBrief("");
                    }
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLength: 500,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText:
                    'Enter the type of hook for the article\'s opening sentence',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                provider.updateIntroductoryHookBrief(val);
              },
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
                children: structure.contentOptions.keys.map((option) {
                  return _buildYesNoDropdown(
                    option,
                    structure.contentOptions[option],
                    (val) {
                      provider.updateContentOption(option, val ?? false);
                    },
                    itemWidth,
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildYesNoDropdown(
    String label,
    bool? selected,
    void Function(bool?) onChanged,
    double width,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: CustomDropdownTile(
        label: label,
        items: AppConstants.yesNoOptions,
        selectedValue: selected == true ? 'Yes' : 'No',
        onChanged: (val) {
          onChanged(val == 'Yes');
        },
      ),
    );
  }
}
