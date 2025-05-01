import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/domain/entities/article_builder_entities.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';

class MediaHubCard extends StatefulWidget {
  final ArticleBuilderEntity articleBuilderEntity;

  const MediaHubCard({
    super.key,
    required this.articleBuilderEntity,
  });

  @override
  State<MediaHubCard> createState() => _MediaHubCardState();
}

class _MediaHubCardState extends State<MediaHubCard> {
  late TextEditingController additionalInstructionsController;
  late TextEditingController brandNameController;

  @override
  void initState() {
    super.initState();
    // Inicializamos los controladores con los valores actuales de la entidad
    additionalInstructionsController = TextEditingController(
      text: widget.articleBuilderEntity.articleMediaHub.additionalInstructions,
    );
    brandNameController = TextEditingController(
      text: widget.articleBuilderEntity.articleMediaHub.brandName,
    );
  }

  @override
  void dispose() {
    // Liberamos los controladores al destruir el widget
    additionalInstructionsController.dispose();
    brandNameController.dispose();
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
            Row(
              children: [
                const Text(
                  'Media Hub',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 110, 110, 110)),
                ),
                const SizedBox(width: 8),
                Icon(Icons.info_outline, size: 18, color: Colors.grey.shade600),
              ],
            ),
            const SizedBox(height: 20),
            CustomDropdownTile(
              label: 'AI Images',
              items: AppConstants.aiImagesOptions,
              selectedValue:
                  widget.articleBuilderEntity.articleMediaHub.aiImages
                      ? 'Yes'
                      : 'No',
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.aiImages =
                      val == 'Yes';
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Number of Images',
              items: AppConstants.numberOfImagesOptions
                  .map((e) => e.toString())
                  .toList(),
              selectedValue: widget
                  .articleBuilderEntity.articleMediaHub.numberOfImages
                  .toString(),
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.numberOfImages =
                      int.parse(val!);
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Image Style',
              items: AppConstants.imageStyles,
              selectedValue:
                  widget.articleBuilderEntity.articleMediaHub.imageStyle,
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.imageStyle = val!;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Image Size',
              items: AppConstants.imageSizes,
              selectedValue:
                  widget.articleBuilderEntity.articleMediaHub.imageSize,
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.imageSize = val!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: additionalInstructionsController,
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Additional Instructions',
                border: OutlineInputBorder(),
                hintText: 'Enter details or creative directions',
              ),
              onChanged: (val) {
                widget.articleBuilderEntity.articleMediaHub
                    .additionalInstructions = val;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: brandNameController,
              maxLength: 30,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                border: OutlineInputBorder(),
                hintText: 'Enter your brand name',
              ),
              onChanged: (val) {
                widget.articleBuilderEntity.articleMediaHub.brandName = val;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: widget
                      .articleBuilderEntity.articleMediaHub.includeKeywords,
                  onChanged: (val) {
                    setState(() {
                      widget.articleBuilderEntity.articleMediaHub
                          .includeKeywords = val!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Include the main keyword in the first image as Alt-text.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select YouTube Videos',
              items: AppConstants.youtubeVideosOptions,
              selectedValue:
                  widget.articleBuilderEntity.articleMediaHub.youtubeVideos
                      ? 'Yes'
                      : 'No',
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.youtubeVideos =
                      val as bool;
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Number of Videos',
              items: AppConstants.numberOfVideosOptions
                  .map((e) => e.toString())
                  .toList(),
              selectedValue: widget
                  .articleBuilderEntity.articleMediaHub.numberOfVideos
                  .toString(),
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.numberOfVideos =
                      int.parse(val!);
                });
              },
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Layout Option',
              items: AppConstants.layoutOptions,
              selectedValue:
                  widget.articleBuilderEntity.articleMediaHub.layoutOption,
              onChanged: (val) {
                setState(() {
                  widget.articleBuilderEntity.articleMediaHub.layoutOption =
                      val!;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: widget
                      .articleBuilderEntity.articleMediaHub.placeUnderHeadings,
                  onChanged: (val) {
                    setState(() {
                      widget.articleBuilderEntity.articleMediaHub
                          .placeUnderHeadings = val!;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'All media elements will be placed strictly under the headings.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
