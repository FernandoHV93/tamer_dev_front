import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';

class ContentCard extends StatefulWidget {
  final ContentCardEntity contentCard;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isSelected;

  const ContentCard({
    super.key,
    required this.contentCard,
    required this.onPressed,
    required this.onEdit,
    required this.onDelete,
    this.isSelected = false,
  });

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  bool isHovered = false;
  bool isEditHovered = false;
  bool isDeleteHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 5,
            width: 370,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
              color: widget.contentCard.status == ContentCardStatus.ready
                  ? const Color.fromARGB(180, 0, 21, 255)
                  : const Color.fromARGB(180, 255, 165, 0),
            ),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedScale(
              scale: widget.isSelected ? 1.04 : 1.0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  border: widget.isSelected
                      ? Border.all(
                          color: const Color.fromARGB(255, 23, 87, 223),
                          width: 2.5,
                        )
                      : null,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isSelected
                          ? const Color.fromARGB(80, 23, 87, 223)
                          : Colors.black12,
                      blurRadius: widget.isSelected ? 18 : (isHovered ? 10 : 2),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(370, 240),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    overlayColor: Colors.white,
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                  ),
                  onPressed: widget.onPressed,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 10, 7, 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 25,
                              color: widget.contentCard.status ==
                                      ContentCardStatus.ready
                                  ? const Color.fromARGB(255, 40, 58, 253)
                                  : const Color.fromARGB(255, 255, 165, 0),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.contentCard.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isHovered
                                      ? const Color.fromARGB(180, 0, 21, 255)
                                      : Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            MouseRegion(
                              onEnter: (_) =>
                                  setState(() => isEditHovered = true),
                              onExit: (_) =>
                                  setState(() => isEditHovered = false),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      isEditHovered ? Colors.blue : Colors.grey,
                                  size: 16,
                                ),
                                onPressed: widget.onEdit,
                              ),
                            ),
                            const SizedBox(width: 8),
                            MouseRegion(
                              onEnter: (_) =>
                                  setState(() => isDeleteHovered = true),
                              onExit: (_) =>
                                  setState(() => isDeleteHovered = false),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.delete,
                                  color: isDeleteHovered
                                      ? Colors.red
                                      : Colors.grey,
                                  size: 16,
                                ),
                                onPressed: widget.onDelete,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStat('KD SCORE',
                                '${widget.contentCard.keyWordsScore} %'),
                            _buildStat('STATUS',
                                widget.contentCard.status.name.toUpperCase()),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(thickness: 0.8),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'URL',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black87),
                            ),
                            Expanded(
                              child: Text(
                                widget.contentCard.url ?? 'No URL',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 28,
          ),
        ),
      ],
    );
  }
}
