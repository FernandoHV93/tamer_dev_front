import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/views/article_builder/components/custom_dropdown.dart';

class MediaHubCard extends StatefulWidget {
  const MediaHubCard({super.key});

  @override
  State<MediaHubCard> createState() => _MediaHubCardState();
}

class _MediaHubCardState extends State<MediaHubCard> {
  String? aiImages = 'No';
  int numberOfImages = 1;
  String? imageStyle = 'None';
  String? imageSize = '1344x768(16:9)';
  String? youtubeVideos = 'No';
  int numberOfVideos = 1;
  String? layoutOption = 'Alternate image and video';
  bool includeAltText = false;
  bool strictMediaPlacement = false;

  final TextEditingController additionalInstructionsController =
      TextEditingController();
  final TextEditingController brandNameController = TextEditingController();

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
              selectedValue: aiImages,
              onChanged: (val) => setState(() => aiImages = val),
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Number of Images',
              items: AppConstants.numberOfImagesOptions
                  .map((e) => e.toString())
                  .toList(),
              selectedValue: numberOfImages.toString(),
              onChanged: (val) =>
                  setState(() => numberOfImages = int.parse(val!)),
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Image Style',
              items: AppConstants.imageStyles,
              selectedValue: imageStyle,
              onChanged: (val) => setState(() => imageStyle = val),
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Image Size',
              items: AppConstants.imageSizes,
              selectedValue: imageSize,
              onChanged: (val) => setState(() => imageSize = val),
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
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: includeAltText,
                  onChanged: (val) => setState(() => includeAltText = val!),
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
              selectedValue: youtubeVideos,
              onChanged: (val) => setState(() => youtubeVideos = val),
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Number of Videos',
              items: AppConstants.numberOfVideosOptions
                  .map((e) => e.toString())
                  .toList(),
              selectedValue: numberOfVideos.toString(),
              onChanged: (val) =>
                  setState(() => numberOfVideos = int.parse(val!)),
            ),
            const SizedBox(height: 16),
            CustomDropdownTile(
              label: 'Select Layout Option',
              items: AppConstants.layoutOptions,
              selectedValue: layoutOption,
              onChanged: (val) => setState(() => layoutOption = val),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: strictMediaPlacement,
                  onChanged: (val) =>
                      setState(() => strictMediaPlacement = val!),
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
