import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/input_with_button.dart';

class ArticleForm extends StatefulWidget {
  const ArticleForm({super.key});

  @override
  State<ArticleForm> createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  String? selectedLanguage = 'English(US)';
  String? selectedArticleType = 'None';

  final Map<String, String> languages = {
    'English(US)': 'assets/images/flags/usa.png',
    'Spanish': 'assets/images/flags/spain.png',
    'French': 'assets/images/flags/france.png',
    'German': 'assets/images/flags/germany.png',
    'Italian': 'assets/images/flags/italy.png',
  };

  final Map<String, IconData> articleTypes = {
    'None': Icons.do_not_disturb_alt,
    'How-to Guide': Icons.menu_book,
    'Listicle': Icons.format_list_bulleted,
    'Product Review': Icons.work,
    'News': Icons.newspaper,
  };

  final TextEditingController keywordController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Language',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownTile(
                        label: 'Select Language',
                        items: languages.keys.toList(),
                        selectedValue: selectedLanguage,
                        onChanged: (val) => setState(() {
                          selectedLanguage = val;
                        }),
                        images: languages.values
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
                            fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 10),
                      CustomDropdownTile(
                        label: 'Select Article Type',
                        items: articleTypes.keys.toList(),
                        selectedValue: selectedArticleType,
                        onChanged: (val) => setState(() {
                          selectedArticleType = val;
                        }),
                        icons: articleTypes.values.toList(),
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
                // Acción del botón para análisis de palabras clave
              },
            ),
            const SizedBox(height: 20),
            InputWithButton(
              title: 'Title',
              controller: titleController,
              hint: 'Enter title',
              buttonLabel: 'Run Analysis First',
              onPressed: () {
                // Acción del botón para analizar título
              },
            ),
          ],
        ),
      ),
    );
  }
}
