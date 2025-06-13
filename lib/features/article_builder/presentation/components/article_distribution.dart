import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/custom_dropdown.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/section_header.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';

class ArticleDistributionSection extends StatefulWidget {
  const ArticleDistributionSection({
    super.key,
  });

  @override
  State<ArticleDistributionSection> createState() =>
      _ArticleDistributionSectionState();
}

class _ArticleDistributionSectionState
    extends State<ArticleDistributionSection> {
  late TextEditingController linkController;
  @override
  void initState() {
    super.initState();
    linkController = TextEditingController();
  }

  @override
  void dispose() {
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleBuilderProvider>(
        builder: (context, provider, child) {
      final distribution = provider.articleBuilderEntity.articleDistribution;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Connect to Web',
            tooltip: '',
          ),
          const SizedBox(height: 8),
          CustomDropdownTile(
            label: 'Source Links',
            selectedValue: distribution.sourceLinks ? 'Yes' : 'No',
            items: AppConstants.yesNoOptions,
            onChanged: (val) {
              provider.updateSourceLinks(val == 'Yes');
            },
            note:
                'At the bottom of the article, a list of used sources will be displayed. You can choose the format in which these sources are presented.',
          ),
          const SizedBox(height: 12),
          CustomDropdownTile(
            label: 'Citations ✨',
            selectedValue: distribution.citations ? 'Yes' : 'No',
            items: AppConstants.yesNoOptions,
            onChanged: (val) {
              provider.updateCitations(val == 'Yes');
            },
            note:
                'At the end of the sentence, it includes a citation link to the source of the factual data utilized in crafting the content.',
          ),
          const SizedBox(height: 20),
          _buildLinkingCard(
            title: 'Internal Linking',
            links: distribution.internalLinking,
            onAddLink: (newLink) {
              final updatedLinks =
                  List<String>.from(distribution.internalLinking)..add(newLink);
              provider.updateInternalLinking(updatedLinks);
            },
            onRemoveLink: (link) {
              final updatedLinks =
                  List<String>.from(distribution.internalLinking)..remove(link);
              provider.updateInternalLinking(updatedLinks);
            },
            note:
                'Automatically index your site and add links relevant to your content. Select a WordPress Site and our semantic search will find the best pages to link to within your article.',
          ),
          const SizedBox(height: 16),
          _buildLinkingCard(
            title: 'External Linking',
            links: distribution.externalLinking,
            onAddLink: (newLink) {
              final updatedLinks =
                  List<String>.from(distribution.externalLinking)..add(newLink);
              provider.updateExternalLinking(updatedLinks);
            },
            onRemoveLink: (link) {
              final updatedLinks =
                  List<String>.from(distribution.externalLinking)..remove(link);
              provider.updateExternalLinking(updatedLinks);
            },
            note:
                'External Linking automatically integrates authoritative and relevant external links into your content, while also allowing you to manually specify desired links.',
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Syndication',
            tooltip:
                'Create marketing materials based on the article for various platforms.',
          ),
          const SizedBox(height: 10),
          const Text(
            'Select the platforms where you want to syndicate your article.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: AppConstants.syndicationOptions.entries.map((entry) {
              final platform = entry.key;
              final iconPath = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    activeColor: Colors.blue,
                    value: distribution.articleSydication[platform] ?? false,
                    onChanged: (val) {
                      provider.updateSyndicationOption(platform, val ?? false);
                    },
                  ),
                  Image.asset(iconPath, width: 24, height: 24),
                  const SizedBox(width: 6),
                  Text(
                    platform,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildLinkingCard({
    required String title,
    required List<String> links,
    required void Function(String) onAddLink,
    required void Function(String) onRemoveLink,
    required String note,
  }) {
    return Card(
      elevation: 1,
      color: const Color.fromARGB(255, 41, 41, 41),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: title,
              tooltip: '',
            ),
            const SizedBox(height: 8),
            CustomDropdownTile(
              label: 'Select or Add Link',
              items: ['Add Link', ...links],
              selectedValue: null,
              onChanged: (val) {
                if (val == 'Add Link') {
                  _showAddLinkDialog(context, onAddLink);
                }
              },
              note: note,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: links.map((link) {
                return Chip(
                  label: Text(link),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    onRemoveLink(link);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddLinkDialog(
      BuildContext context, void Function(String) onAddLink) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 50, 50, 50),
          title: const Text(
            'Add Link',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: linkController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter URL',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                final newLink = linkController.text.trim();
                if (newLink.isNotEmpty) {
                  onAddLink(newLink);
                  linkController.clear();
                  Navigator.of(dialogContext).pop();
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
