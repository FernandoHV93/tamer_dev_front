import 'package:flutter/material.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:ia_web_front/data/models/models.dart';

class TableBlockWidget extends StatelessWidget {
  final TableBlock block;
  final WidgetsController controller;
  const TableBlockWidget(
      {super.key, required this.block, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: block.rows.asMap().entries.map((entry) {
        int rowIndex = entry.key;
        List<String> row = entry.value;
        return Row(
          children: row.asMap().entries.map((cellEntry) {
            int colIndex = cellEntry.key;
            String cellText = cellEntry.value;
            final controllerText = TextEditingController(text: cellText);
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: controllerText,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (val) {
                    block.rows[rowIndex][colIndex] = val;
                    controller.updateBlock(
                        block.id, TableBlock(id: block.id, rows: block.rows));
                  },
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
