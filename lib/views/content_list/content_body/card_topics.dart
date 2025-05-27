import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/website_model.dart';

class CardTopic extends StatelessWidget {
  final List<Topics> topics;

  const CardTopic({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Keyword')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Score')),
        DataColumn(label: Text('Words')),
        DataColumn(label: Text('Schemas')),
        DataColumn(label: Text('Status')),
      ],
      rows: topics.map((topic) {
        return DataRow(cells: [
          DataCell(Text(topic.keyWord)),
          DataCell(Text(topic.date)),
          DataCell(Text(topic.score ?? 'N/A')),
          DataCell(Text(topic.words ?? 'N/A')),
          DataCell(Text(topic.schemas ?? 'N/A')),
          DataCell(Text(topic.status.name)),
        ]);
      }).toList(),
    );
  }
}
