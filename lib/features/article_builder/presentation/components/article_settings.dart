import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/brand_voice_card.dart';
import 'package:ia_web_front/features/brand_voice/presentation/provider/brand_voice_provider.dart';
import 'package:ia_web_front/features/brand_voice/domain/entities/brand_voice_entity.dart';

class ArticleSettingsCard extends StatefulWidget {
  const ArticleSettingsCard({super.key});

  @override
  State<ArticleSettingsCard> createState() => _ArticleSettingsCardState();
}

class _ArticleSettingsCardState extends State<ArticleSettingsCard> {
  static const aiWordsRemovalOptions = [
    'No AI Words Removal',
    'Basic AI Words Removal',
    'Extended AI Words Removal',
  ];

  Color _getAiWordsRemovalColor(String value) {
    switch (value) {
      case 'No AI Words Removal':
        return Colors.amber;
      case 'Basic AI Words Removal':
        return Colors.orangeAccent;
      case 'Extended AI Words Removal':
        return Colors.greenAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleBuilderProvider>();
    final settings = provider.articleBuilderEntity.articleSettings;

    return Center(
      child: Container(
        constraints: const BoxConstraints(
            maxWidth: AppConstants.kArticleBuilderMaxWidth),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Article Settings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Primera fila: Article Size, Size Details, Target Country
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Article Size
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Article Size',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: settings.articleSize,
                        items: AppConstants.sizeDetails.keys.map((size) {
                          return DropdownMenuItem<String>(
                            value: size,
                            child: Text(size,
                                style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateArticleSize(val);
                        },
                        dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 30, 30, 30),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF363A45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF2563EB)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                // Size Details
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Size Details',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF363A45),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          AppConstants.sizeDetails[settings.articleSize] ?? '',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                // Target Country
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Target Country',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: settings.targetCountry,
                        items: AppConstants.languages.keys.map((lang) {
                          return DropdownMenuItem<String>(
                            value: lang,
                            child: Row(
                              children: [
                                if (AppConstants.languages[lang] != null)
                                  Image.asset(AppConstants.languages[lang]!,
                                      width: 20, height: 20),
                                const SizedBox(width: 8),
                                Text(lang,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateTargetCountry(val);
                        },
                        dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 30, 30, 30),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF363A45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF2563EB)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Segunda fila: AI Model, Humanize Text + AI Words Removal
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AI Model
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AI Model',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: settings.aiModel,
                        items: AppConstants.aiModels.map((model) {
                          return DropdownMenuItem<String>(
                            value: model,
                            child: Text(model,
                                style: const TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateAiModel(val);
                        },
                        dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 30, 30, 30),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF363A45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF2563EB)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                // Humanize Text + AI Words Removal
                Expanded(
                  flex: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Humanize Text
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Humanize Text',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: settings.humanizeText,
                              items: AppConstants.humanLevels.map((level) {
                                return DropdownMenuItem<String>(
                                  value: level,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(level,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      Text(
                                        AppConstants.humanDescriptions[level] ??
                                            '',
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              selectedItemBuilder: (context) =>
                                  AppConstants.humanLevels.map((level) {
                                return Text(level,
                                    style:
                                        const TextStyle(color: Colors.white));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null)
                                  provider.updateHumanizeText(val);
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 30, 30, 30),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 30, 30, 30),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF363A45)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF2563EB)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 18),
                      // AI Words Removal
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('AI Words Removal',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: settings.aiWordsRemoval,
                              items: aiWordsRemovalOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      color: _getAiWordsRemovalColor(option),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null)
                                  provider.updateAiWordsRemoval(val);
                              },
                              dropdownColor:
                                  const Color.fromARGB(255, 30, 30, 30),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 30, 30, 30),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF363A45)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF2563EB)),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Tercera fila: Point of View, Tone of Voice
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Point of View
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Point of View',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: settings.pointOfView,
                        items: AppConstants.povOptions.map((e) {
                          return DropdownMenuItem<String>(
                            value: e['label'] as String,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(e['icon'] as IconData,
                                        color: Colors.white54, size: 20),
                                    const SizedBox(width: 8),
                                    Text(e['label'] as String,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ],
                                ),
                                Text(
                                  e['desc'] as String,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (context) =>
                            AppConstants.povOptions.map((e) {
                          return Row(
                            children: [
                              Icon(e['icon'] as IconData,
                                  color: Colors.white54, size: 20),
                              const SizedBox(width: 8),
                              Text(e['label'] as String,
                                  style: const TextStyle(color: Colors.white)),
                            ],
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.updatePointOfView(val);
                        },
                        dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 30, 30, 30),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF363A45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF2563EB)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                // Tone of Voice
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tone of Voice',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: settings.toneOfVoice,
                        items: AppConstants.tones.map((e) {
                          return DropdownMenuItem<String>(
                            value: e['label'] as String,
                            child: Row(
                              children: [
                                Icon(e['icon'] as IconData,
                                    color: Colors.white54, size: 20),
                                const SizedBox(width: 8),
                                Text(e['label'] as String,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateToneOfVoice(val);
                        },
                        dropdownColor: const Color.fromARGB(255, 30, 30, 30),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 30, 30, 30),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF363A45)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                const BorderSide(color: Color(0xFF2563EB)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Consumer2<BrandVoiceProvider, ArticleBuilderProvider>(
              builder: (context, brandProvider, articleProvider, _) {
                final brandVoices = brandProvider.savedBrands;
                final brandNames = brandVoices.isNotEmpty
                    ? brandVoices.map((b) => b.brandName).toList()
                    : ['None'];
                final selectedBrandMap = articleProvider.selectedBrandVoice;
                String selectedBrandName =
                    selectedBrandMap['brandName'] as String? ?? 'None';

                articleProvider.ensureBrandVoiceInitialized(brandVoices);

                if (!brandNames.contains(selectedBrandName)) {
                  selectedBrandName = brandNames.first;
                }
                return BrandVoiceCard(
                  brandVoices: brandNames,
                  selectedVoice: selectedBrandName,
                  onAdd: () {
                    Navigator.pushNamed(context, '/brand_voice');
                  },
                  onChanged: (String? newName) {
                    final selected = brandVoices.firstWhere(
                      (b) => b.brandName == newName,
                      orElse: () => brandVoices.isNotEmpty
                          ? brandVoices.first
                          : BrandVoice(
                              id: '',
                              brandName: 'None',
                              toneOfVoice: '',
                              keyValues: [],
                              targetAudience: '',
                              brandIdentityInsights: '',
                            ),
                    );
                    if (selected != null) {
                      articleProvider.setSelectedBrandVoice({
                        'id': selected.id,
                        'brandName': selected.brandName,
                        'toneOfVoice': selected.toneOfVoice,
                        'keyValues': selected.keyValues,
                        'targetAudience': selected.targetAudience,
                        'brandIdentityInsights': selected.brandIdentityInsights,
                      });
                    }
                    // print eliminado para producción
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
