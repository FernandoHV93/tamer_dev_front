import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
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
      return Center(
        child: Container(
          constraints: const BoxConstraints(
              maxWidth: AppConstants.kArticleBuilderMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Connect to Web',
                tooltip: '',
              ),
              const SizedBox(height: 8),
              // Source Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Source Links',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                          value: distribution.sourceLinks ? 'Yes' : 'No',
                          items: AppConstants.yesNoOptions
                              .map((val) => DropdownMenuItem(
                                    value: val,
                                    child: Text(val,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            provider.updateSourceLinks(val == 'Yes');
                          },
                          dropdownColor: const Color.fromARGB(255, 30, 30, 30),
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
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'At the bottom of the article, a list of used sources will be displayed. You can choose the format in which these sources are presented.',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Citations
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Citations ✨',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        child: DropdownButtonFormField<String>(
                          value: distribution.citations ? 'Yes' : 'No',
                          items: AppConstants.yesNoOptions
                              .map((val) => DropdownMenuItem(
                                    value: val,
                                    child: Text(val,
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            provider.updateCitations(val == 'Yes');
                          },
                          dropdownColor: const Color.fromARGB(255, 30, 30, 30),
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
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          'At the end of the sentence, it includes a citation link to the source of the factual data utilized in crafting the content.',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF363A45)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Internal Linking',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(width: 8),
                        Icon(Icons.info_outline,
                            color: Colors.white70, size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Automatically index your site and add links relevant to your content. Select a WordPress Site and our semantic search will find the best pages to link to within your article.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 18),
                    const Text('Select a WordPress Site',
                        style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: distribution.internalLinking.isEmpty
                          ? 'None'
                          : 'Add Link',
                      items: ['None', 'Add Link']
                          .map((val) => DropdownMenuItem(
                                value: val,
                                child: Text(val,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val == 'Add Link') {
                          _showAddLinkDialog(context, (newLink) {
                            final updatedLinks =
                                List<String>.from(distribution.internalLinking)
                                  ..add(newLink);
                            provider.updateInternalLinking(updatedLinks);
                          });
                        }
                      },
                      dropdownColor: const Color.fromARGB(255, 30, 30, 30),
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
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: distribution.internalLinking.map((link) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(30, 96, 165, 250),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                link,
                                style: const TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  final updatedLinks = List<String>.from(
                                      distribution.internalLinking)
                                    ..remove(link);
                                  provider.updateInternalLinking(updatedLinks);
                                },
                                child: const Icon(Icons.close,
                                    color: Color(0xFF2563EB), size: 18),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF363A45)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('External Linking',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(width: 8),
                        Icon(Icons.info_outline,
                            color: Colors.white70, size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'External Linking automatically integrates authoritative and relevant external links into your content, while also allowing you to manually specify desired links.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 18),
                    const Text('Select or Add Link',
                        style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.w600,
                            fontSize: 14)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: distribution.externalLinking.isEmpty
                          ? 'None'
                          : 'Add Link',
                      items: ['None', 'Add Link']
                          .map((val) => DropdownMenuItem(
                                value: val,
                                child: Text(val,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val == 'Add Link') {
                          _showAddLinkDialog(context, (newLink) {
                            final updatedLinks =
                                List<String>.from(distribution.externalLinking)
                                  ..add(newLink);
                            provider.updateExternalLinking(updatedLinks);
                          });
                        }
                      },
                      dropdownColor: const Color.fromARGB(255, 30, 30, 30),
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
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: distribution.externalLinking.map((link) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(30, 96, 165, 250),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                link,
                                style: const TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  final updatedLinks = List<String>.from(
                                      distribution.externalLinking)
                                    ..remove(link);
                                  provider.updateExternalLinking(updatedLinks);
                                },
                                child: const Icon(Icons.close,
                                    color: Color(0xFF2563EB), size: 18),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Syndication
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF363A45)),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Syndication',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(width: 8),
                        Icon(Icons.info_outline,
                            color: Colors.white70, size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select the platforms where you want to syndicate your article.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children:
                          AppConstants.syndicationOptions.entries.map((entry) {
                        final platform = entry.key;
                        final iconPath = entry.value;
                        final isSelected =
                            distribution.articleSydication[platform] ?? false;
                        return GestureDetector(
                          onTap: () {
                            provider.updateSyndicationOption(
                                platform, !isSelected);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2563EB).withOpacity(0.08)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF2563EB)
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(iconPath, width: 24, height: 24),
                                const SizedBox(width: 8),
                                Text(
                                  _prettyPlatformName(platform),
                                  style: TextStyle(
                                    color: isSelected
                                        ? const Color(0xFF2563EB)
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (val) {
                                    provider.updateSyndicationOption(
                                        platform, val ?? false);
                                  },
                                  activeColor: const Color(0xFF2563EB),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // External Linking
            ],
          ),
        ),
      );
    });
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

  String _prettyPlatformName(String key) {
    switch (key) {
      case 'twitterPost':
        return 'Twitter';
      case 'linkedinPost':
        return 'LinkedIn';
      case 'facebookPost':
        return 'Facebook';
      case 'emailNewsletter':
        return 'Email';
      case 'whatsappMessage':
        return 'WhatsApp';
      case 'pinterestPin':
        return 'Pinterest';
      default:
        return key;
    }
  }
}
