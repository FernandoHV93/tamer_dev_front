import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';
import 'package:ia_web_front/views/article_builder/components/section_header.dart';

class ArticleDistributionSection extends StatefulWidget {
  final ArticleBuilderEntity articleBuilderEntity;

  const ArticleDistributionSection({
    super.key,
    required this.articleBuilderEntity,
  });

  @override
  State<ArticleDistributionSection> createState() =>
      _ArticleDistributionSectionState();
}

class _ArticleDistributionSectionState
    extends State<ArticleDistributionSection> {
  late TextEditingController linkController;
  late TextEditingController internalLinkController;
  late TextEditingController externalLinkController;
  @override
  void initState() {
    super.initState();
    internalLinkController = TextEditingController();
    externalLinkController = TextEditingController();
  }

  @override
  void dispose() {
    internalLinkController.dispose();
    externalLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Connect to Web',
          tooltip: '',
        ),
        const SizedBox(height: 8),
        // CustomDropdownTile(
        //   label: 'Source Links',
        //   selectedValue:
        //       widget.articleBuilderEntity.articleDistribution.sourceLinks
        //           ? 'True'
        //           : 'False',
        //   items: AppConstants.yesNoOptions,
        //   onChanged: (val) {
        //     setState(() {
        //       widget.articleBuilderEntity.articleDistribution.sourceLinks =
        //           val == 'True';
        //     });
        //   },
        //   note:
        //       'At the bottom of the article, a list of used sources will be displayed. You can choose the format in which these sources are presented.',
        // ),
        // const SizedBox(height: 12),
        // CustomDropdownTile(
        //   label: 'Citations ✨',
        //   selectedValue:
        //       widget.articleBuilderEntity.articleDistribution.citations
        //           ? 'True'
        //           : 'False',
        //   items: AppConstants.yesNoOptions,
        //   onChanged: (val) {
        //     setState(() {
        //       widget.articleBuilderEntity.articleDistribution.citations =
        //           val == 'True';
        //     });
        //   },
        //   note:
        //       'At the end of the sentence, it includes a citation link to the source of the factual data utilized in crafting the content.',
        // ),
        const SizedBox(height: 20),
        _buildLinkingCard(
          title: 'Internal Linking',
          links:
              widget.articleBuilderEntity.articleDistribution.externalLinking,
          onAddLink: (newLink) {
            setState(() {
              widget.articleBuilderEntity.articleDistribution.externalLinking
                  .add(newLink);
            });
          },
          note:
              'Automatically index your site and add links relevant to your content. Select a WordPress Site and our semantic search will find the best pages to link to within your article.',
        ),
        const SizedBox(height: 16),
        _buildLinkingCard(
          title: 'External Linking',
          links:
              widget.articleBuilderEntity.articleDistribution.internalLinking,
          onAddLink: (newLink) {
            setState(() {
              widget.articleBuilderEntity.articleDistribution.internalLinking
                  .add(newLink);
            });
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
                  value: widget.articleBuilderEntity.articleDistribution
                      .articleSydication[platform],
                  onChanged: (val) {
                    setState(() {
                      widget.articleBuilderEntity.articleDistribution
                          .articleSydication[platform] = val ?? false;
                    });
                  },
                ),
                Image.asset(iconPath, width: 24, height: 24),
                const SizedBox(width: 6),
                Text(platform),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLinkingCard({
    required String title,
    required List<String> links,
    required void Function(String) onAddLink,
    required String note,
  }) {
    return Card(
      elevation: 1,
      color: const Color(0xFFF9F9F9),
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
                  _showAddLinkDialog(onAddLink);
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
                    setState(() {
                      links.remove(link);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddLinkDialog(void Function(String) onAddLink) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Link'),
          content: TextField(
            controller: linkController,
            decoration: const InputDecoration(
              hintText: 'Enter URL',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newLink = linkController.text.trim();
                if (newLink.isNotEmpty) {
                  onAddLink(newLink);
                  linkController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
