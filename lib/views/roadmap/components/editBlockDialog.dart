import 'package:flutter/material.dart';
import 'package:ia_web_front/domain/entities/block.dart';

class EditBlockDialog extends StatefulWidget {
  final Block block;
  final Function(Block updatedBlock) onSave;

  const EditBlockDialog({
    super.key,
    required this.block,
    required this.onSave,
  });

  @override
  State<EditBlockDialog> createState() => _EditBlockDialogState();
}

class _EditBlockDialogState extends State<EditBlockDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController articleUrlController;
  late TextEditingController contextController;
  late String selectedLabel;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.block.title);
    descriptionController = TextEditingController(
        text: widget.block.comments.isNotEmpty ? widget.block.comments[0] : '');
    articleUrlController = TextEditingController(
        text: widget.block.links.isNotEmpty ? widget.block.links[0] : '');
    contextController =
        TextEditingController(text: widget.block.context["context"] ?? "");
    selectedLabel = widget.block.label;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Title"),
            _buildField(titleController),
            _buildLabel("Description"),
            _buildField(descriptionController),
            _buildLabel("Article URL"),
            _buildField(articleUrlController),
            _buildLabel("Context"),
            _buildField(contextController),
            _buildLabel("Status"),
            Wrap(
              spacing: 8,
              children: ["Done", "To Fix", "To Check"].map((label) {
                final color = label == "Done"
                    ? Colors.green
                    : label == "To Fix"
                        ? Colors.red
                        : const Color.fromARGB(255, 183, 140, 11);
                return ChoiceChip(
                  backgroundColor: color,
                  label: Text(label),
                  selected: selectedLabel == label,
                  selectedColor: color,
                  onSelected: (_) {
                    setState(() {
                      selectedLabel = label;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedBlock = widget.block;
            updatedBlock.title = titleController.text;
            updatedBlock.comments = [descriptionController.text];
            updatedBlock.links = [articleUrlController.text];
            updatedBlock.label = selectedLabel;
            updatedBlock.context = {
              ...updatedBlock.context,
              "context": contextController.text.trim().isEmpty
                  ? "Sin contexto"
                  : contextController.text.trim(),
            };
            widget.onSave(updatedBlock);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

  Widget _buildField(TextEditingController controller) => TextField(
        controller: controller,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      );
}
