import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';

class ArticleSettingsCard extends StatefulWidget {
  const ArticleSettingsCard({super.key});

  @override
  State<ArticleSettingsCard> createState() => _ArticleSettingsCardState();
}

class _ArticleSettingsCardState extends State<ArticleSettingsCard> {
  String? articleSize;
  String? targetCountry;
  String? aiModel;
  String? humanizeLevel;
  String? pointOfView;
  String? toneOfVoice;

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
            Text(
              'Article Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                final isMedium = constraints.maxWidth > 500;

                Widget rowOrColumn(List<Widget> children) {
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children
                          .map((child) => Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: child,
                              )))
                          .toList(),
                    );
                  } else if (isMedium) {
                    return Column(
                      children: [
                        Row(
                          children: children
                              .sublist(0, 2)
                              .map((child) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16, bottom: 16),
                                      child: child,
                                    ),
                                  ))
                              .toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: children.length > 2
                              ? children[2]
                              : const SizedBox(),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: children
                          .map((child) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: child,
                              ))
                          .toList(),
                    );
                  }
                }

                return Column(
                  children: [
                    rowOrColumn([
                      CustomDropdownTile(
                        label: 'Article Size',
                        items: AppConstants.sizeDetails.keys.toList(),
                        selectedValue: articleSize,
                        onChanged: (val) => setState(() => articleSize = val),
                        leadingIcon: Icons.article,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Size Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              articleSize != null
                                  ? AppConstants.sizeDetails[articleSize!]!
                                  : 'Select article size to see details',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomDropdownTile(
                        label: 'Target Country',
                        items: AppConstants.languages.keys.toList(),
                        selectedValue: targetCountry,
                        onChanged: (val) => setState(() => targetCountry = val),
                        leadingIcon: Icons.flag,
                        images: AppConstants.languages.values
                            .map((path) => Image.asset(
                                  path,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    rowOrColumn([
                      CustomDropdownTile(
                        label: 'AI Model',
                        items: AppConstants.aiModels,
                        selectedValue: aiModel,
                        onChanged: (val) => setState(() => aiModel = val),
                        leadingIcon: Icons.smart_toy,
                      ),
                      CustomDropdownTile(
                        label: 'Humanize Text',
                        items: AppConstants.humanLevels,
                        selectedValue: humanizeLevel,
                        onChanged: (val) => setState(() => humanizeLevel = val),
                        leadingIcon: Icons.psychology_alt,
                        itemDescriptions: AppConstants.humanDescriptions,
                      ),
                    ]),
                    const SizedBox(height: 20),
                    rowOrColumn([
                      CustomDropdownTile(
                        label: 'Point of View',
                        items: AppConstants.povOptions
                            .map((e) => e['label'] as String)
                            .toList(),
                        selectedValue: pointOfView,
                        onChanged: (val) => setState(() => pointOfView = val),
                        leadingIcon: Icons.person,
                        icons: AppConstants.povOptions
                            .map((e) => e['icon'] as IconData)
                            .toList(),
                        itemDescriptions: {
                          for (var e in AppConstants.povOptions)
                            e['label'] as String: e['desc'] as String
                        },
                      ),
                      CustomDropdownTile(
                        label: 'Tone of Voice',
                        items: AppConstants.tones
                            .map((e) => e['label'] as String)
                            .toList(),
                        selectedValue: toneOfVoice,
                        onChanged: (val) => setState(() => toneOfVoice = val),
                        icons: AppConstants.tones
                            .map((e) => e['icon'] as IconData)
                            .toList(),
                      ),
                    ]),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
