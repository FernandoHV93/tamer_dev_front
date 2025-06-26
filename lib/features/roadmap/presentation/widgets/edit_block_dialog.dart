import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

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

  Color _labelColor(String lbl) {
    switch (lbl) {
      case 'Done':
        return const Color(0xFF4ADE80);
      case 'To Check':
        return const Color(0xFFFACC15);
      case 'To Fix':
        return const Color(0xFFF87171);
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF23272F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 16,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.edit, color: Colors.blueAccent, size: 28),
                    SizedBox(width: 10),
                    Text('Edit Block',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 18),
                // Title
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: const Color(0xFF181A20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white24)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueAccent)),
                  ),
                ),
                const SizedBox(height: 16),
                // Label
                Row(
                  children: ['Done', 'To Check', 'To Fix'].map((lbl) {
                    final isSelected = label == lbl;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          lbl,
                          style: TextStyle(
                            color:
                                isSelected ? _labelColor(lbl) : Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: const Color(0xFF23272F),
                        backgroundColor: const Color(0xFF23272F),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(
                            color: _labelColor(lbl)
                                .withOpacity(isSelected ? 0.7 : 0.3)),
                        checkmarkColor: Colors.white,
                        onSelected: (_) {
                          setState(() {
                            label = lbl;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
                // Comments
                Text('Comments',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentInput,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Add Comment',
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: const Color(0xFF181A20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_comment,
                                color: Colors.blueAccent),
                            onPressed: addComment,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...comments.map(
                  (c) => Card(
                    color: Colors.white.withOpacity(0.04),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      leading: const Icon(Icons.comment,
                          size: 18, color: Colors.blueAccent),
                      title:
                          Text(c, style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Links
                Text('Links',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: linkInput,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Add Link',
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: const Color(0xFF181A20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blueAccent)),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_link,
                                color: Colors.pinkAccent),
                            onPressed: addLink,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ...links.map(
                  (l) => Card(
                    color: Colors.white.withOpacity(0.04),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      leading: const Icon(Icons.link,
                          size: 18, color: Colors.pinkAccent),
                      title:
                          Text(l, style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                      ),
                      child:
                          const Text('Cancel', style: TextStyle(fontSize: 16)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
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
                      child: const Text('Save',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
