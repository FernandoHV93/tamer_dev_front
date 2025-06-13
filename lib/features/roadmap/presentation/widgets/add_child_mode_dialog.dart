import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';
import 'package:ia_web_front/features/roadmap/presentation/widgets/child_option_button.dart';

class AddBlockDialog extends StatelessWidget {
  final Block parent;
  final VoidCallback onSingleChild;
  final VoidCallback onBulkGenerate;

  const AddBlockDialog({
    super.key,
    required this.parent,
    required this.onSingleChild,
    required this.onBulkGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Add Content',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChildOptionButton(
            title: 'Single Child',
            description:
                'Add a single article node. Best for adding individual pieces of content.',
            borderColor: Colors.blueAccent,
            textColor: const Color.fromARGB(255, 104, 164, 213),
            onPressed: () {
              Navigator.pop(context);
              onSingleChild();
            },
          ),
          const SizedBox(height: 5),
          ChildOptionButton(
            title: 'Bulk Generate',
            description:
                'Generate multiple articles at once. Perfect for planning content clusters.',
            borderColor: Colors.pinkAccent,
            textColor: Colors.pinkAccent,
            onPressed: () {
              Navigator.pop(context);
              onBulkGenerate();
            },
          ),
        ],
      ),
    );
  }
}
