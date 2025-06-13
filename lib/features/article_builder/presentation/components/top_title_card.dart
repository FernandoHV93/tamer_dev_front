import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_builder/domain/entities/article_builder_entities.dart';

class TopTitleCard extends StatelessWidget {
  final ArticleBuilderEntity articleBuilderEntity;
  final VoidCallback onSave;
  final VoidCallback onGenerate;
  const TopTitleCard({
    super.key,
    required this.articleBuilderEntity,
    required this.onSave,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color.fromARGB(255, 41, 41, 41),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.edit_document,
              size: 35,
              color: Colors.blue,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Article Generator',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
                Text(
                  'Generate and publish article with just 1 click',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onSave,
                child: Text(
                  'Save Data',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onGenerate,
              child: const Text(
                'RUN',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
