import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/website_model.dart';

class TopicClusters extends StatefulWidget {
  final List<ContentCardModel> contentCards;

  const TopicClusters({super.key, required this.contentCards});

  @override
  State<TopicClusters> createState() => _TopicClustersState();
}

class _TopicClustersState extends State<TopicClusters> {
  String? selectedContentCardTitle;
  String sortBy = 'KD';

  @override
  void initState() {
    super.initState();
    // Seleccionar la primera content card por defecto
    if (widget.contentCards.isNotEmpty) {
      selectedContentCardTitle = widget.contentCards.first.title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header con título y botón
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Covered Keywords',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Acción para ver recomendaciones
                },
                icon: const Icon(Icons.lightbulb_outline, color: Colors.white),
                label: const Text(
                  'View Recommendations',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 5, 60, 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Contenido principal con altura específica en lugar de Expanded
        SizedBox(
          height: MediaQuery.of(context).size.height -
              200, // Ajusta según necesites
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Panel izquierdo - Topic Clusters
              SizedBox(
                width: 280,
                child: Container(
                  margin: const EdgeInsets.only(left: 16, right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Topic Clusters',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          child: ListView.builder(
                            itemCount: widget.contentCards.length,
                            itemBuilder: (context, index) {
                              final contentCard = widget.contentCards[index];
                              final isSelected =
                                  contentCard.title == selectedContentCardTitle;

                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    _getIconForContentCard(contentCard),
                                    color: isSelected
                                        ? Colors.purple
                                        : Colors.blue,
                                    size: 20,
                                  ),
                                  title: Text(
                                    contentCard.title,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Colors.purple
                                          : Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    '${contentCard.topics?.length ?? 0} keywords covered',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  selected: isSelected,
                                  selectedTileColor: Colors.purple.shade50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedContentCardTitle =
                                          contentCard.title;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Panel derecho - Tabla de Keywords
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Header de la tabla con título del cluster seleccionado
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getfirstContentCard().title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Sort by:',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Material(
                                  color: Colors.transparent,
                                  child: DropdownButton<String>(
                                    value: sortBy,
                                    underline: Container(),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'KD',
                                        child: Text('KD'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Volume',
                                        child: Text('Volume'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Position',
                                        child: Text('Position'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        sortBy = value ?? 'KD';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Headers de columnas
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        child: const Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                'KEYWORD',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'KD',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'VOLUME',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'POSITION',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'STATUS',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'ACTIONS',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Lista de keywords (topics)
                      Expanded(
                        child: _getSelectedTopics().isNotEmpty
                            ? ListView.builder(
                                itemCount: _getSelectedTopics().length,
                                itemBuilder: (context, index) {
                                  final topic = _getSelectedTopics()[index];
                                  return TopicTableItem(topic: topic);
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No topics available for this content card',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Topics> _getSelectedTopics() {
    final selectedCard = widget.contentCards.firstWhere(
      (card) => card.title == selectedContentCardTitle,
      orElse: () => widget.contentCards.first,
    );
    return selectedCard.topics ?? [];
  }

  ContentCardModel _getfirstContentCard() {
    final selectedCard = widget.contentCards.first;
    return selectedCard;
  }

  IconData _getIconForContentCard(ContentCardModel contentCard) {
    // Puedes personalizar los iconos según el contenido o status
    switch (contentCard.status) {
      case InspectedWebsiteStatus.Done:
        return Icons.check_circle;
      case InspectedWebsiteStatus.NoDone:
        return Icons.pending;
      default:
        return Icons.article;
    }
  }
}

class TopicTableItem extends StatelessWidget {
  final Topics topic;

  const TopicTableItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Keyword
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.keyWord,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (topic.categories != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    topic.categories!,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ],
            ),
          ),

          // KD
          Expanded(
            child: Center(
              child: Text(
                topic.kd != null ? '${topic.kd}%' : '-',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _getKDColor(topic.kd),
                ),
              ),
            ),
          ),

          // Volume
          Expanded(
            child: Text(
              '${topic.volume?.toString()}K',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),

          // Position
          Expanded(
            child: Center(
              child: topic.position != null
                  ? Center(
                      child: Text(
                        '${topic.position}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getPositionColor(topic.position!),
                        ),
                      ),
                    )
                  : const Text('-', style: TextStyle(color: Colors.grey)),
            ),
          ),

          // Status
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(topic.status),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getStatusBorderColor(topic.status),
                  ),
                ),
                child: Text(
                  _getStatusText(topic.status),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getStatusTextColor(topic.status),
                  ),
                ),
              ),
            ),
          ),

          // Actions
          Expanded(
            child: Center(
              child: IconButton(
                icon: const Icon(Icons.edit, size: 18),
                color: Colors.grey.shade600,
                onPressed: () {
                  // Acción de editar
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getKDColor(String? kd) {
    if (kd == null) return Colors.grey;
    final kdValue = int.tryParse(kd.replaceAll('%', '')) ?? 0;
    if (kdValue <= 30) return Colors.green;
    if (kdValue <= 50) return Colors.orange;
    return Colors.red;
  }

  Color _getPositionColor(int position) {
    if (position <= 3) return Colors.green;
    if (position <= 10) return Colors.orange;
    return Colors.red.shade300;
  }

  Color _getStatusColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.Covered:
        return Colors.green.shade50;
      case TopicStatus.Draft:
        return Colors.orange.shade50;
      case TopicStatus.Initiated:
        return Colors.red.shade50;
    }
  }

  Color _getStatusBorderColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.Covered:
        return Colors.green.shade200;
      case TopicStatus.Draft:
        return Colors.orange.shade200;
      case TopicStatus.Initiated:
        return Colors.red.shade200;
    }
  }

  Color _getStatusTextColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.Covered:
        return Colors.green.shade700;
      case TopicStatus.Draft:
        return Colors.orange.shade700;
      case TopicStatus.Initiated:
        return Colors.red.shade700;
    }
  }

  String _getStatusText(TopicStatus status) {
    switch (status) {
      case TopicStatus.Covered:
        return 'Covered';
      case TopicStatus.Draft:
        return 'Drafted';
      case TopicStatus.Initiated:
        return 'Initiated';
    }
  }
}
