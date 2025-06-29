import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/content/presentation/widgets/loading_indicator.dart';

class TopicClustersView extends StatefulWidget {
  final SessionProvider sessionProvider;

  const TopicClustersView({super.key, required this.sessionProvider});

  @override
  State<TopicClustersView> createState() => _TopicClustersViewState();
}

class _TopicClustersViewState extends State<TopicClustersView> {
  String? selectedCardId;
  String sortBy = 'KD';
  List<String> _lastCardIds = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contentProvider =
          Provider.of<ContentProvider>(context, listen: false);
      if (contentProvider.contentCards.isNotEmpty) {
        if (mounted) {
          setState(() {
            selectedCardId = contentProvider.contentCards.first.id;
            _lastCardIds =
                contentProvider.contentCards.map((c) => c.id).toList();
          });
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant TopicClustersView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final contentProvider =
        Provider.of<ContentProvider>(context, listen: false);
    final currentCardIds =
        contentProvider.contentCards.map((c) => c.id).toList();
    if (_lastCardIds.join(',') != currentCardIds.join(',')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (contentProvider.contentCards.isNotEmpty) {
            setState(() {
              selectedCardId = contentProvider.contentCards.first.id;
              _lastCardIds = currentCardIds;
            });
          } else {
            setState(() {
              selectedCardId = null;
              _lastCardIds = [];
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final cards = contentProvider.contentCards;
    final isLoadingTopics = contentProvider.isLoadingTopics;

    if (cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 80,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 24),
              const Text(
                'No Content to Analyze',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'There are no content cards for this website yet.\nOnce you add content, your topic clusters will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        // Paneles con altura fija para evitar problemas de render
        SizedBox(
          height: 500,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            final card = cards[index];
                            final isSelected = card.id == selectedCardId;
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              child: ListTile(
                                title: Text(
                                  card.title,
                                  style: TextStyle(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.blue.shade700
                                        : Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '${contentProvider.getTopicsForCard(card.id).length} keywords covered',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                selected: isSelected,
                                selectedTileColor: Colors.blue.shade50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onTap: () {
                                  setState(() {
                                    selectedCardId = card.id;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 8, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
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
                              _getSelectedCardTitle(cards),
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
                      Expanded(
                        child: isLoadingTopics
                            ? const LoadingIndicator(text: 'Loading topics...')
                            : _getSelectedTopics(contentProvider).isNotEmpty
                                ? ListView.builder(
                                    itemCount:
                                        _getSelectedTopics(contentProvider)
                                            .length,
                                    itemBuilder: (context, index) {
                                      final topic = _getSelectedTopics(
                                          contentProvider)[index];
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

  String _getSelectedCardTitle(List<ContentCardEntity> cards) {
    final card = cards.firstWhere(
      (c) => c.id == selectedCardId,
      orElse: () => cards.isNotEmpty
          ? cards.first
          : ContentCardEntity(
              id: '',
              websiteId: '',
              title: '',
              keyWordsScore: 0,
              status: ContentCardStatus.ready),
    );
    return card.title;
  }

  List<TopicEntity> _getSelectedTopics(ContentProvider provider) {
    if (selectedCardId == null) return [];
    final topics = provider.getTopicsForCard(selectedCardId!);
    // Ordenar topics según sortBy
    if (sortBy == 'KD') {
      topics.sort((a, b) => _parseKD(a.kd).compareTo(_parseKD(b.kd)));
    } else if (sortBy == 'Volume') {
      topics.sort((a, b) => (b.volume ?? 0).compareTo(a.volume ?? 0));
    } else if (sortBy == 'Position') {
      topics.sort((a, b) => (a.position ?? 9999).compareTo(b.position ?? 9999));
    }
    return topics;
  }

  int _parseKD(String? kd) {
    if (kd == null) return 9999;
    return int.tryParse(kd.replaceAll('%', '')) ?? 9999;
  }
}

class TopicTableItem extends StatelessWidget {
  final TopicEntity topic;

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
                if (topic.categories != null &&
                    topic.categories!.isNotEmpty) ...[
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
              topic.volume != null ? '${topic.volume}K' : '-',
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
      case TopicStatus.covered:
        return Colors.green.shade50;
      case TopicStatus.draft:
        return Colors.orange.shade50;
      case TopicStatus.initiated:
        return Colors.red.shade50;
    }
  }

  Color _getStatusBorderColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.covered:
        return Colors.green.shade200;
      case TopicStatus.draft:
        return Colors.orange.shade200;
      case TopicStatus.initiated:
        return Colors.red.shade200;
    }
  }

  Color _getStatusTextColor(TopicStatus status) {
    switch (status) {
      case TopicStatus.covered:
        return Colors.green.shade700;
      case TopicStatus.draft:
        return Colors.orange.shade700;
      case TopicStatus.initiated:
        return Colors.red.shade700;
    }
  }

  String _getStatusText(TopicStatus status) {
    switch (status) {
      case TopicStatus.covered:
        return 'Covered';
      case TopicStatus.draft:
        return 'Drafted';
      case TopicStatus.initiated:
        return 'Initiated';
    }
  }
}
