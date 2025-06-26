import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/article_builder/presentation/controller/article_builder_provider.dart';
import 'package:provider/provider.dart';

class MediaHubCard extends StatelessWidget {
  const MediaHubCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleBuilderProvider>();
    final mediaHub = provider.articleBuilderEntity.articleMediaHub;

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
                const Text(
                  'Media Hub',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.info_outline, size: 18, color: Colors.white),
              ],
            ),
            const SizedBox(height: 24),
            // Primera fila: AI Images, Number of images, Image style, Image Size
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AI Images Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AI Images',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: mediaHub.aiImages
                            ? AppConstants.aiImagesOptions[1]
                            : AppConstants.aiImagesOptions[0],
                        items: AppConstants.aiImagesOptions
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          provider.updateAiImages(
                              val == AppConstants.aiImagesOptions[1]);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Number of images Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Number of images',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<int>(
                        value: mediaHub.numberOfImages,
                        items: AppConstants.numberOfImagesOptions
                            .map((num) => DropdownMenuItem(
                                  value: num,
                                  child: Text('$num',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateNumberOfImages(val);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Image style Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Image style',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: mediaHub.imageStyle,
                        items: AppConstants.imageStyles
                            .map((style) => DropdownMenuItem(
                                  value: style,
                                  child: Text(style,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateImageStyle(val);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        menuMaxHeight: 250,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Image Size Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Image Size',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: (mediaHub.imageSize['width'] != 0 &&
                                mediaHub.imageSize['height'] != 0)
                            ? '${mediaHub.imageSize['width']}x${mediaHub.imageSize['height']}'
                            : AppConstants.imageSizes.first,
                        items: AppConstants.imageSizes
                            .map((size) => DropdownMenuItem(
                                  value: size,
                                  child: Text(size,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) {
                            final parts = val.split('x');
                            provider.updateImageSize({
                              'width': int.parse(parts[0]),
                              'height': int.parse(parts[1]),
                            });
                          }
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Segunda fila: Additional Instructions y Brand Name
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Additional Instructions',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        maxLength: 100,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'Enter details or creative directions',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Color(0xFF232733),
                          counterStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        onChanged: (val) {
                          provider.updateAdditionalInstructions(val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Brand Name',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        maxLength: 30,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText: 'Enter your brand name',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          filled: true,
                          fillColor: Color(0xFF232733),
                          counterStyle: TextStyle(color: Colors.white54),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        onChanged: (val) {
                          provider.updateBrandName(val);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Checkbox: Include main keyword
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: mediaHub.includeKeywords,
                  onChanged: (val) {
                    provider.updateIncludeKeywords(val!);
                  },
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                          'Include the main keyword in the first image as ',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF60A5FA))),
                      const Text('Alt-text.',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF60A5FA),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                            'Relevant keywords will be picked up and added to the rest of the images.',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Fila de opciones de video
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // YouTube videos Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('YouTube videos',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: mediaHub.youtubeVideos
                            ? AppConstants.youtubeVideosOptions[1]
                            : AppConstants.youtubeVideosOptions[0],
                        items: AppConstants.youtubeVideosOptions
                            .map((val) => DropdownMenuItem(
                                  value: val,
                                  child: Text(val,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          provider.updateYoutubeVideos(
                              val == AppConstants.youtubeVideosOptions[1]);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Number of videos Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Number of videos',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<int>(
                        value: mediaHub.numberOfVideos,
                        items: AppConstants.numberOfVideosOptions
                            .map((num) => DropdownMenuItem(
                                  value: num,
                                  child: Text('$num',
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateNumberOfVideos(val);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Layout options Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Layout Options',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: mediaHub.layoutOption,
                        items: AppConstants.layoutOptions
                            .map((layout) => DropdownMenuItem(
                                  value: layout,
                                  child: Text(layout,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ))
                            .toList(),
                        onChanged: (val) {
                          if (val != null) provider.updateLayoutOption(val);
                        },
                        dropdownColor: const Color(0xFF181A20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF181A20),
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
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Checkbox: All media elements...
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: Colors.blue,
                  value: mediaHub.placeUnderHeadings,
                  onChanged: (val) {
                    provider.updatePlaceUnderHeadings(val!);
                  },
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                          'All media elements will be placed strictly under the headings.',
                          style: TextStyle(
                              fontSize: 14, color: Color(0xFF60A5FA))),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                            'If disabled, the AI will decide and find the best placement.',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white70)),
                      ),
                    ],
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
