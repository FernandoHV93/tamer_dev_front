import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/keyword_analysis_result_card.dart';

class MainForm extends StatefulWidget {
  final VoidCallback onSave;
  final VoidCallback onGenerate;
  final void Function(bool isAutoMode)? onAnalysis;
  const MainForm(
      {super.key,
      required this.onSave,
      required this.onGenerate,
      this.onAnalysis});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  late TextEditingController keywordController;
  late TextEditingController titleController;
  bool toggleValue = false;
  bool isHovering = false;

  @override
  void initState() {
    super.initState();
    keywordController = TextEditingController();
    titleController = TextEditingController();
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
        final mainKeyword = keywordController.text.trim();
        final isAnalysisEnabled = mainKeyword.isNotEmpty;
        final sessionProvider = SessionProvider.of(context);
        final sessionId = sessionProvider.sessionID;
        final userId = sessionProvider.userID;
        return Center(
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: AppConstants.kArticleBuilderMaxWidth),
            decoration: BoxDecoration(
              color: const Color(0xFF181A20),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.edit_document,
                        size: 35, color: Color(0xFF2563EB)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Article Generator',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Generate and publish article in 1 click',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white38,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: widget.onSave,
                      child: const Text('Save Data',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: widget.onGenerate,
                      child: const Text('Run',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Language',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: articleBuilderEntity
                                .articleGeneratorGeneral.language,
                            items: AppConstants.languages.keys.map((lang) {
                              return DropdownMenuItem<String>(
                                value: lang,
                                child: Row(
                                  children: [
                                    Image.asset(AppConstants.languages[lang]!,
                                        width: 20, height: 20),
                                    const SizedBox(width: 8),
                                    Text(lang,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) provider.updateLanguage(val);
                            },
                            dropdownColor: const Color(0xFF232733),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF232733),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Article Type',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: articleBuilderEntity
                                .articleGeneratorGeneral.articleType,
                            items: AppConstants.articleTypes.keys.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(AppConstants.articleTypes[type],
                                        color: Colors.white, size: 18),
                                    const SizedBox(width: 8),
                                    Text(type,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) provider.updateArticleType(val);
                            },
                            dropdownColor: const Color(0xFF232733),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF232733),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Main Keyword',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: keywordController,
                        onChanged: (val) {
                          setState(() {});
                          _updateKeyword();
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter your main keyword',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: const Color(0xFF232733),
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
                    ),
                    const SizedBox(width: 12),
                    Tooltip(
                      message: toggleValue ? 'Auto Mode' : 'Manual Mode',
                      child: Switch(
                        value: toggleValue,
                        onChanged: (val) => setState(() => toggleValue = val),
                        activeColor: const Color(0xFF2563EB),
                        inactiveTrackColor: const Color(0xFF363A45),
                      ),
                    ),
                    const SizedBox(width: 8),
                    MouseRegion(
                      onEnter: (_) => setState(() => isHovering = true),
                      onExit: (_) => setState(() => isHovering = false),
                      child: GestureDetector(
                        onTap: isAnalysisEnabled
                            ? () => provider.runAnalysis(sessionId, userId,
                                keywordController.text, toggleValue)
                            : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isAnalysisEnabled
                                ? (isHovering
                                    ? const Color(0xFF2563EB)
                                    : Colors.transparent)
                                : const Color(0xFF232733),
                            border: Border.all(
                              color: isAnalysisEnabled
                                  ? const Color(0xFF2563EB)
                                  : const Color(0xFF363A45),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Analysis',
                            style: TextStyle(
                              color: isAnalysisEnabled
                                  ? (isHovering
                                      ? Colors.white
                                      : const Color(0xFF2563EB))
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (toggleValue && provider.analysisResult != null)
                  KeywordAnalysisResultCard(result: provider.analysisResult!),
                const SizedBox(height: 24),
                Text('Title',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 10),
                TextField(
                  controller: titleController,
                  onChanged: (val) => _updateTitle(),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your blog title or topic',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF232733),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF363A45)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF2563EB)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Meta Title',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (val) => provider.updateArticleMetaTitle(val),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your meta title',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    filled: true,
                    fillColor: const Color(0xFF232733),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF363A45)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF2563EB)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
