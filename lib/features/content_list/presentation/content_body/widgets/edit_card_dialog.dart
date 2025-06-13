import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';

import 'package:provider/provider.dart';

class EditCardDialog extends StatefulWidget {
  final ContentCardModel? contentCard;
  const EditCardDialog({super.key, this.contentCard});

  @override
  State<EditCardDialog> createState() => _EditCardDialogState();
}

class _EditCardDialogState extends State<EditCardDialog> {
  String? selectedWebsite;
  final TextEditingController cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final websiteController = Provider.of<WebsiteController>(context);
    final websites = websiteController.websites;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Card',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Card Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose a descriptive name for your content topic',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cardNameController,
              decoration: InputDecoration(
                hintText: 'e.g., SEO Best Practices',
                hintStyle: TextStyle(color: Colors.black38),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 23, 87, 223),
                      width: 2), // Azul con grosor 2
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Associated Website',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Select a website to associate this topic with (optional)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedWebsite,
              items: websites.map((website) {
                return DropdownMenuItem<String>(
                  value: website.name,
                  child: Text(website.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedWebsite = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 23, 87, 223),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (widget.contentCard != null && selectedWebsite != null) {
                      final websiteController = Provider.of<WebsiteController>(
                          context,
                          listen: false);
                      final selectedWebsiteObject =
                          websiteController.websites.firstWhere(
                        (website) => website.name == selectedWebsite,
                      );

                      // Llama al método editContentCard
                      websiteController.editContentCard(
                        websiteController.selectedWebsite!.contentCards!
                            .indexOf(widget.contentCard!),
                        cardNameController.text,
                        selectedWebsiteObject,
                      );

                      Navigator.of(context).pop(); // Cierra el diálogo
                    }
                  },
                  child: const Text('Edit Card'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
