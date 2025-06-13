import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/presentation/controller/websites_controller.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddTopicDialog extends StatefulWidget {
  const AddTopicDialog({
    super.key,
  });

  @override
  State<AddTopicDialog> createState() => _AddTopicDialogState();
}

class _AddTopicDialogState extends State<AddTopicDialog> {
  String? selectedWebsite;
  final TextEditingController topicMainKeyWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final websiteController = Provider.of<WebsiteController>(context);

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
              'Add New Topic',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Keyword',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 96, 96, 96),
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: topicMainKeyWord,
              decoration: InputDecoration(
                hintText: 'Enter the main keyword for the topic',
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
                    // Lógica para añadir la tarjeta
                    if (topicMainKeyWord.text.isNotEmpty) {
                      final newTopic = Topics(
                        keyWord: topicMainKeyWord.text,
                        date: DateFormat('yyyy-MM-dd HH:mm')
                            .format(DateTime.now()),
                        status: TopicStatus.Initiated,
                      );
                      final selectedCardIndex = websiteController
                          .selectedWebsite!.contentCards
                          ?.indexOf(websiteController.selectedContentCard!);
                      if (selectedCardIndex != null) {
                        websiteController.addTopic(selectedCardIndex, newTopic);
                      }
                      Navigator.of(context).pop(); // Cerrar el diálogo
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a Topic main keyword'),
                        ),
                      );
                    }
                  },
                  child: const Text('Add Topic'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
