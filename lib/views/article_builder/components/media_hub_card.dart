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

  Map<String, int> imageSizeStringToMap(String imageSize) {
    RegExp regExp = RegExp(r'(\d+)x(\d+)');
    Match? match = regExp.firstMatch(imageSize);

    if (match != null) {
      // Asignar los valores capturados (group 1 y group 2)
      int height = int.parse(match.group(1)!); // 1080
      int width = int.parse(match.group(2)!); // 1920

      Map<String, int> imageSizeMap = {
        "width": width,
        "height": height,
      };
      return imageSizeMap;
    } else {
      return {
        "width": 0,
        "height": 0,
      };
    }
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
      color: const Color.fromARGB(255, 41, 41, 41),
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
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.info_outline, size: 18, color: Colors.white),
              ],
            ),
            const SizedBox(height: 20),

            // AI Images y Select Number of Images en una fila
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
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
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select Number of Images',
                    items: AppConstants.numberOfImagesOptions
                        .map((e) => e.toString())
                        .toList(),
                    selectedValue: widget
                        .articleBuilderEntity.articleMediaHub.numberOfImages
                        .toString(),
                    onChanged: (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleMediaHub
                            .numberOfImages = int.parse(val!);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Select Image Style y Select Image Size en una fila
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select Image Style',
                    items: AppConstants.imageStyles,
                    selectedValue:
                        widget.articleBuilderEntity.articleMediaHub.imageStyle,
                    onChanged: (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleMediaHub.imageStyle =
                            val!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select Image Size',
                    items: AppConstants.imageSizes,
                    selectedValue: AppConstants.imageSizes.first,
                    onChanged: (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleMediaHub.imageSize =
                            imageSizeStringToMap(val ?? "");
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Select YouTube Videos y Select Number of Videos en una fila
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select YouTube Videos',
                    items: AppConstants.youtubeVideosOptions,
                    selectedValue: widget
                            .articleBuilderEntity.articleMediaHub.youtubeVideos
                        ? 'Yes'
                        : 'No',
                    onChanged: (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleMediaHub
                            .youtubeVideos = val == 'Yes';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select Number of Videos',
                    items: AppConstants.numberOfVideosOptions
                        .map((e) => e.toString())
                        .toList(),
                    selectedValue: widget
                        .articleBuilderEntity.articleMediaHub.numberOfVideos
                        .toString(),
                    onChanged: (val) {
                      setState(() {
                        widget.articleBuilderEntity.articleMediaHub
                            .numberOfVideos = int.parse(val!);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Additional Instructions
            TextField(
              controller: additionalInstructionsController,
              style: TextStyle(color: Colors.white),
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Additional Instructions',
                labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                border: OutlineInputBorder(),
                hintText: 'Enter details or creative directions',
                hintStyle: const TextStyle(
                  color: Colors.grey, // Cambia este color al que desees
                  fontSize: 14,
                ),
              ),
              onChanged: (val) {
                widget.articleBuilderEntity.articleMediaHub
                    .additionalInstructions = val;
              },
            ),
            const SizedBox(height: 16),

            // Brand Name
            TextField(
              controller: brandNameController,
              style: TextStyle(color: Colors.white),
              maxLength: 30,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                border: OutlineInputBorder(),
                hintText: 'Enter your brand name',
                hintStyle: const TextStyle(
                  color: Colors.grey, // Cambia este color al que desees
                  fontSize: 14,
                ),
              ),
              onChanged: (val) {
                widget.articleBuilderEntity.articleMediaHub.brandName = val;
              },
            ),
            const SizedBox(height: 16),

            // Include Keywords Checkbox
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
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
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Place Under Headings Checkbox
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
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
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
