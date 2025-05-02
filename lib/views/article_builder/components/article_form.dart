import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/input_with_button.dart';

class ArticleForm extends StatefulWidget {
  final ArticleBuilderEntity articleBuilderEntity;

  const ArticleForm({
    super.key,
    required this.articleBuilderEntity,
  });

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  late TextEditingController keywordController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los valores actuales de la entidad
    keywordController = TextEditingController(
      text: widget
          .articleBuilderEntity.articleGeneratorGeneral.articleMainKeyword,
    );
    titleController = TextEditingController(
      text: widget.articleBuilderEntity.articleGeneratorGeneral.articleTitle,
    );
  }

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget
    keywordController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Color(0xFFF9F9F9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownTile(
                        label: 'Select Language',
                        items: AppConstants.languages.keys.toList(),
                        selectedValue: widget.articleBuilderEntity
                            .articleGeneratorGeneral.language,
                        onChanged: (val) {
                          setState(() {
                            widget.articleBuilderEntity.articleGeneratorGeneral
                                .language = val!;
                          });
                        },
                        images: AppConstants.languages.values
                            .map((path) => Image.asset(
                                  path,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Article Type',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownTile(
                        label: 'Select Article Type',
                        items: AppConstants.articleTypes.keys.toList(),
                        selectedValue: widget.articleBuilderEntity
                            .articleGeneratorGeneral.articleType,
                        onChanged: (val) {
                          setState(() {
                            widget.articleBuilderEntity.articleGeneratorGeneral
                                .articleType = val!;
                          });
                        },
                        icons: AppConstants.articleTypes.values.toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            InputWithButton(
              title: 'Main Keywords',
              controller: keywordController,
              hint: 'Enter main keywords',
              buttonLabel: 'Analysis',
              onPressed: () {
                // Actualizamos los datos en la entidad
                widget.articleBuilderEntity.articleGeneratorGeneral
                    .articleMainKeyword = keywordController.text;
              },
            ),
            const SizedBox(height: 20),
            InputWithButton(
              title: 'Title',
              controller: titleController,
              hint: 'Enter title',
              buttonLabel: 'Run Analysis First',
              onPressed: () {
                // Actualizamos los datos en la entidad
                widget.articleBuilderEntity.articleGeneratorGeneral
                    .articleTitle = titleController.text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
