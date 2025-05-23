import 'package:flutter/material.dart';

class ContentCard extends StatefulWidget {
  final String title;
  final int kdScore;
  final String volume;
  final int completed;
  final int total;

  const ContentCard({
    super.key,
    required this.title,
    required this.kdScore,
    required this.volume,
    required this.completed,
    required this.total,
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
          Container(
            height: 5,
            width: 360,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
              color: const Color.fromARGB(180, 0, 21, 255),
            ),
          ),
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: isHovered ? 10 : 2,
                overlayColor: Colors.white,
                shadowColor: Colors.black54,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(3),
                    bottomRight: Radius.circular(3),
                  ),
                ),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(7, 10, 7, 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.search,
                          size: 25,
                          color: Color.fromARGB(255, 40, 58, 253),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.title,
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
                          onEnter: (_) => setState(() => isEditHovered = true),
                          onExit: (_) => setState(() => isEditHovered = false),
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(
                              Icons.edit,
                              color: isEditHovered ? Colors.blue : Colors.grey,
                              size: 16,
                            ),
                            onPressed: () {},
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
                              color: isDeleteHovered ? Colors.red : Colors.grey,
                              size: 16,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStat('KD SCORE', '${widget.kdScore} %'),
                        _buildStat('VOLUME', '${widget.volume}.0K'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(thickness: 0.8),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Completion',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        Text(
                          '${widget.completed}/${widget.total}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    )
                  ],
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
