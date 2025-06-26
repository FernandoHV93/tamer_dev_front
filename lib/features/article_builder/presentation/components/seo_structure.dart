import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/section_header.dart';

class SeoStructure extends StatelessWidget {
  const SeoStructure({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleBuilderProvider>();
    final seo = provider.articleBuilderEntity.articleSEO;
    final structure = provider.articleBuilderEntity.articleStructure;
    final TextEditingController _keywordController = TextEditingController();
    final int keywordCharCount =
        seo.keywords.fold(0, (sum, k) => sum + k.length);

    return Center(
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: AppConstants.kArticleBuilderMaxWidth),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Seo',
              tooltip: 'Keywords will be used to generate relevant content.',
            ),
            const SizedBox(height: 12),
            // Label y contador
            Row(
              children: [
                const Text(
                  'Keywords to include in the text',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const Spacer(),
                Text(
                  '$keywordCharCount/150',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // TextField + botón NLP
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _keywordController,
                    decoration: InputDecoration(
                      hintText: 'Write keywords and press Enter',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2563EB)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF363A45)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF2563EB)),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 30, 30, 30),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                    onSubmitted: (val) {
                      final keyword = val.trim();
                      if (keyword.isNotEmpty) {
                        provider.addKeyword(keyword);
                        _keywordController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Aquí va tu lógica de NLP keywords generation
                  },
                  child: const Text('NLP keywords generation'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Texto de ayuda
            const Text(
              'Keywords will be used to generate relevant content. You can add them manually or generate them automatically.',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 8),
            // Chips de keywords
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: seo.keywords.map((keyword) {
                return Chip(
                  label: Text(keyword,
                      style: const TextStyle(color: Colors.white)),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    provider.removeKeyword(keyword);
                  },
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.hookOptions.map((hook) {
                final isSelected = structure.typeOfHook == hook;
                return ChoiceChip(
                  label: Text(
                    hook,
                    style: TextStyle(
                      color:
                          isSelected ? Colors.white : const Color(0xFF2563EB),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(255, 30, 30, 30),
                  selectedColor: const Color(0xFF2563EB),
                  side: const BorderSide(
                    color: Color(0xFF2563EB),
                    width: 1.5,
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white70),
              maxLength: 500,
              maxLines: 8,
              controller:
                  TextEditingController(text: structure.introductoryHookBrief),
              decoration: InputDecoration(
                hintText:
                    "Enter the type of hook for the article's opening sentence",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF363A45)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 30, 30, 30),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
            LayoutBuilder(
              builder: (context, constraints) {
                final double maxWidth = constraints.maxWidth;
                final int columnCount = (maxWidth ~/ 270).clamp(1, 3);
                final double itemWidth = (maxWidth / columnCount) - 16;

                return Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: structure.contentOptions.keys.map((option) {
                    final selected = structure.contentOptions[option] == true;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: itemWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            option,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: selected ? 'Yes' : 'No',
                            items: AppConstants.yesNoOptions
                                .map((val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(val,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              provider.updateContentOption(
                                  option, val == 'Yes');
                            },
                            dropdownColor:
                                const Color.fromARGB(255, 30, 30, 30),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromARGB(255, 30, 30, 30),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF363A45)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Color(0xFF2563EB)),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
