import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/custom_dropdown.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/input_with_button.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';

class ArticleForm extends StatefulWidget {
  const ArticleForm({
    super.key,
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
    keywordController = TextEditingController();
    titleController = TextEditingController();

    // Inicializar los controladores con los valores del provider después del primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ArticleBuilderProvider>();
      keywordController.text = provider
          .articleBuilderEntity.articleGeneratorGeneral.articleMainKeyword;
      titleController.text =
          provider.articleBuilderEntity.articleGeneratorGeneral.articleTitle;
    });
  }

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget
    keywordController.dispose();
    titleController.dispose();
    super.dispose();
  }

  void _updateKeyword() {
    final provider = context.read<ArticleBuilderProvider>();
    provider.updateArticleMainKeyword(keywordController.text);
  }

  void _updateTitle() {
    final provider = context.read<ArticleBuilderProvider>();
    provider.updateArticleTitle(titleController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleBuilderProvider>(
        builder: (context, provider, child) {
      final articleBuilderEntity = provider.articleBuilderEntity;
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: const Color.fromARGB(255, 41, 41, 41),
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
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        CustomDropdownTile(
                          label: 'Select Language',
                          items: AppConstants.languages.keys.toList(),
                          selectedValue: articleBuilderEntity
                              .articleGeneratorGeneral.language,
                          onChanged: (val) {
                            if (val != null) {
                              provider.updateLanguage(val);
                            }
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
                              color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        CustomDropdownTile(
                          label: 'Select Article Type',
                          items: AppConstants.articleTypes.keys.toList(),
                          selectedValue: articleBuilderEntity
                              .articleGeneratorGeneral.articleType,
                          onChanged: (val) {
                            if (val != null) {
                              provider.updateArticleType(val);
                            }
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
                  _updateKeyword();
                },
                onChanged: (val) {
                  _updateKeyword(); // Actualizar el valor al cambiar el texto
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
                  _updateTitle();
                },
                onChanged: (val) {
                  _updateTitle(); // Actualizar el valor al cambiar el texto
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
