import 'package:flutter/material.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

class ContentCard extends StatefulWidget {
  final ContentCardEntity contentCard;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ContentCard({
    super.key,
    required this.contentCard,
    required this.onPressed,
    required this.onEdit,
    required this.onDelete,
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
    // Obtener topics de la card usando el provider
    final topics = Provider.of<ContentProvider>(context, listen: false)
        .getTopicsForCard(widget.contentCard.id);
    final int totalVolume = topics.fold(0, (sum, t) => sum + (t.volume ?? 0));
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
              color: widget.contentCard.status == ContentCardStatus.done
                  ? const Color.fromARGB(180, 0, 21, 255)
                  : const Color.fromARGB(180, 255, 165, 0),
            ),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: isHovered ? 10 : 2,
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
                                    ContentCardStatus.done
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
                                color:
                                    isDeleteHovered ? Colors.red : Colors.grey,
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
                          _buildStat('VOLUME', totalVolume.toString()),
                          _buildStatusChip(widget.contentCard.status),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 0.8),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 2),
                          child: Text(
                            widget.contentCard.url ?? 'No URL',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
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

  Widget _buildStatusChip(ContentCardStatus status) {
    Color bgColor;
    Color textColor = Colors.white;
    String label;
    IconData? icon;

    switch (status) {
      case ContentCardStatus.done:
        bgColor = const Color(0xFF22C55E); // verde
        label = "Done";
        icon = Icons.check_circle;
        break;
      case ContentCardStatus.in_progress:
        bgColor = const Color(0xFFF59E42); // naranja
        label = "In Progress";
        icon = Icons.timelapse;
        break;
      case ContentCardStatus.no_done:
      default:
        bgColor = const Color(0xFFEF4444); // rojo
        label = "Not Done";
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
