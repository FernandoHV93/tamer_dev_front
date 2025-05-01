import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/section_header.dart';

class SeoStructure extends StatefulWidget {
  final ArticleBuilderEntity articleBuilderEntity;

  const SeoStructure({
    super.key,
    required this.articleBuilderEntity,
  });

  @override
  State<SeoStructure> createState() => _SeoStructureState();
}

class _SeoStructureState extends State<SeoStructure> {
  late TextEditingController keywordsController;
  late TextEditingController hookBriefController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los valores actuales de la entidad
    keywordsController = TextEditingController(
      text: widget.articleBuilderEntity.articleSEO.keywords.join(', '),
    );
    hookBriefController = TextEditingController(
      text: widget.articleBuilderEntity.articleStructure.introductoryHookBrief,
    );
  }

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget
    keywordsController.dispose();
    hookBriefController.dispose();
    super.dispose();
  }

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
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final keyword = keywordsController.text.trim();
                    if (keyword != '') {
                      setState(() {
                        widget.articleBuilderEntity.articleSEO.keywords
                            .add(keyword);
                        keywordsController.clear();
                      });
                    }
                  },
                ),
              ),
              onSubmitted: (val) {
                final keyword = val.trim();
                if (keyword.isNotEmpty) {
                  setState(() {
                    // Agregamos la palabra clave a la lista
                    widget.articleBuilderEntity.articleSEO.keywords
                        .add(keyword);
                    keywordsController.clear(); // Limpiamos el campo de entrada
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.articleBuilderEntity.articleSEO.keywords
                  .map((keyword) {
                return Chip(
                  label: Text(keyword),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      // Eliminamos la palabra clave de la lista
                      widget.articleBuilderEntity.articleSEO.keywords
                          .remove(keyword);
                    });
                  },
                );
              }).toList(),
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
                final isSelected =
                    widget.articleBuilderEntity.articleStructure.typeOfHook ==
                        hook;
                return ChoiceChip(
                  label: Text(hook),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        widget.articleBuilderEntity.articleStructure
                            .typeOfHook = hook;
                        hookBriefController.text =
                            AppConstants.hookPrompts[hook] ?? '';
                      } else {
                        widget.articleBuilderEntity.articleStructure
                            .typeOfHook = "";
                        hookBriefController.clear();
                      }
                    });
                  },
                );
              }).toList(),
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
              onChanged: (val) {
                widget.articleBuilderEntity.articleStructure
                    .introductoryHookBrief = val;
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
                children: widget
                    .articleBuilderEntity.articleStructure.contentOptions.keys
                    .map((option) {
                  return _buildYesNoDropdown(
                    option,
                    widget.articleBuilderEntity.articleStructure
                        .contentOptions[option],
                    (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleStructure
                            .contentOptions[option] = val ?? false;
                      });
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
