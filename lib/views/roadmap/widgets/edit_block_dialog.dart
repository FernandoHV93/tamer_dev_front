import 'package:flutter/material.dart';
import 'package:ia_web_front/views/roadmap/model/roadmap_models.dart';

class EditBlockDialog extends StatefulWidget {
  final Block block;

  const EditBlockDialog({super.key, required this.block});

  @override
  State<EditBlockDialog> createState() => _EditBlockDialogState();
}

class _EditBlockDialogState extends State<EditBlockDialog> {
  late TextEditingController titleController;
  late List<String> comments;
  late List<String> links;
  late String label;
  final TextEditingController commentInput = TextEditingController();
  final TextEditingController linkInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.block.title);
    comments = List.from(widget.block.comments);
    links = List.from(widget.block.links);
    label = widget.block.label;
  }

  @override
  void dispose() {
    titleController.dispose();
    commentInput.dispose();
    linkInput.dispose();
    super.dispose();
  }

  void addComment() {
    final text = commentInput.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.add(text);
        commentInput.clear();
      });
    }
  }

  void addLink() {
    final text = linkInput.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        links.add(text);
        linkInput.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Block'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),

            // Label
            Wrap(
              spacing: 8,
              children: ['Done', 'To Check', 'To Fix'].map((lbl) {
                return ChoiceChip(
                  label: Text(lbl),
                  selected: label == lbl,
                  onSelected: (_) {
                    setState(() {
                      label = lbl;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // Comments
            TextField(
              controller: commentInput,
              decoration: InputDecoration(
                labelText: 'Add Comment',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_comment),
                  onPressed: addComment,
                ),
              ),
            ),
            ...comments.map(
              (c) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.comment, size: 18),
                title: Text(c),
              ),
            ),
            const SizedBox(height: 10),

            // Links
            TextField(
              controller: linkInput,
              decoration: InputDecoration(
                labelText: 'Add Link',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_link),
                  onPressed: addLink,
                ),
              ),
            ),
            ...links.map(
              (l) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.link, size: 18),
                title: Text(l),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedBlock = Block(
              id: widget.block.id,
              position: widget.block.position,
              title: titleController.text.trim(),
              comments: comments,
              links: links,
              label: label,
              context: widget.block.context,
              parentId: widget.block.parentId,
              connections: widget.block.connections,
            );
            Navigator.pop(context, updatedBlock);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
