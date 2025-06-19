import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/article_builder/presentation/components/custom_dropdown.dart';

class MediaHubCard extends StatelessWidget {
  const MediaHubCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleBuilderProvider>();
    final mediaHub = provider.articleBuilderEntity.articleMediaHub;

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
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
                    label: 'AI Images',
                    items: AppConstants.aiImagesOptions,
                    selectedValue: mediaHub.aiImages ? 'Yes' : 'No',
                    onChanged: (val) {
                      provider.updateAiImages(val == 'Yes');
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
                    selectedValue: mediaHub.numberOfImages.toString(),
                    onChanged: (val) {
                      provider.updateNumberOfImages(int.parse(val!));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select Image Style',
                    items: AppConstants.imageStyles,
                    selectedValue: mediaHub.imageStyle,
                    onChanged: (val) {
                      provider.updateImageStyle(val!);
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
                      provider.updateImageSize({
                        "width": int.parse(val!.split('x')[0]),
                        "height": int.parse(val.split('x')[1]),
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomDropdownTile(
                    label: 'Select YouTube Videos',
                    items: AppConstants.youtubeVideosOptions,
                    selectedValue: mediaHub.youtubeVideos ? 'Yes' : 'No',
                    onChanged: (val) {
                      provider.updateYoutubeVideos(val == 'Yes');
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
                    selectedValue: mediaHub.numberOfVideos.toString(),
                    onChanged: (val) {
                      provider.updateNumberOfVideos(int.parse(val!));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLength: 100,
              decoration: const InputDecoration(
                labelText: 'Additional Instructions',
                labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                border: OutlineInputBorder(),
                hintText: 'Enter details or creative directions',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onChanged: (val) {
                provider.updateAdditionalInstructions(val);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLength: 30,
              decoration: const InputDecoration(
                labelText: 'Brand Name',
                labelStyle: TextStyle(fontSize: 14, color: Colors.white),
                border: OutlineInputBorder(),
                hintText: 'Enter your brand name',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              onChanged: (val) {
                provider.updateBrandName(val);
              },
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: mediaHub.includeKeywords,
                  onChanged: (val) {
                    provider.updateIncludeKeywords(val!);
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
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: mediaHub.placeUnderHeadings,
                  onChanged: (val) {
                    provider.updatePlaceUnderHeadings(val!);
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
