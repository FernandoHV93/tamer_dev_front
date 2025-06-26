import 'package:flutter/material.dart';
import 'package:ia_web_front/features/roadmap/domain/model/roadmap_models.dart';

class BuildNivelWidget extends StatelessWidget {
  final NivelData nivel;
  final int index;
  final List<String> availableParents;
  final VoidCallback onToggleExpanded;
  final void Function(String parentId, String title) onAddChildTitle;
  final void Function(String?) onChangeParent;

  const BuildNivelWidget({
    super.key,
    required this.nivel,
    required this.index,
    required this.availableParents,
    required this.onToggleExpanded,
    required this.onAddChildTitle,
    required this.onChangeParent,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return Card(
      color: const Color(0xFF23272F),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.layers,
                        color: Colors.blueAccent, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      nivel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: AnimatedRotation(
                    turns: nivel.expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                  ),
                  onPressed: onToggleExpanded,
                  tooltip: nivel.expanded ? 'Collapse' : 'Expand',
                ),
              ],
            ),
            if (nivel.expanded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index > 0) ...[
                    const SizedBox(height: 12),
                    const Text("Selecciona un padre",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF181A20),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white24),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton<String>(
                        dropdownColor: const Color(0xFF23272F),
                        isExpanded: true,
                        value: nivel.parentId,
                        hint: const Text('Selecciona bloque padre',
                            style: TextStyle(color: Colors.white54)),
                        items: availableParents
                            .map(
                              (parentTitle) => DropdownMenuItem<String>(
                                value: parentTitle,
                                child: Text(parentTitle,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ),
                            )
                            .toList(),
                        onChanged: onChangeParent,
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.blueAccent),
                        underline: const SizedBox(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  if (nivel.parentId != null || index == 0) ...[
                    Text(
                      "Keywords for \\${nivel.parentId ?? 'root'}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: textController,
                      onSubmitted: (value) {
                        if (value.trim().isEmpty) return;
                        onAddChildTitle(nivel.parentId ?? '', value.trim());
                        textController.clear();
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write a title and press Enter to add',
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
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (nivel.childrenPerParent.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: nivel.childrenPerParent.entries.expand((entry) {
                        return entry.value.map(
                          (title) => _ModernKeywordChip(
                            title: title,
                            onDelete: () {
                              nivel.childrenPerParent[entry.key]!.remove(title);
                              (context as Element).markNeedsBuild();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ModernKeywordChip extends StatefulWidget {
  final String title;
  final VoidCallback onDelete;
  const _ModernKeywordChip({required this.title, required this.onDelete});

  @override
  State<_ModernKeywordChip> createState() => _ModernKeywordChipState();
}

class _ModernKeywordChipState extends State<_ModernKeywordChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: _hovering
              ? Colors.blueAccent.withOpacity(0.18)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.18),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
          border: Border.all(
            color: Colors.blueAccent.withOpacity(_hovering ? 0.5 : 0.18),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: widget.onDelete,
              child: Icon(
                Icons.close,
                size: 16,
                color: _hovering ? Colors.redAccent : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
