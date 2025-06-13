import 'package:flutter/material.dart';
import 'package:ia_web_front/features/article_editor/domain/entities/article_editor_models.dart';

class InsertTableDialog extends StatefulWidget {
  const InsertTableDialog({super.key});
  @override
  _InsertTableDialogState createState() => _InsertTableDialogState();
}

class _InsertTableDialogState extends State<InsertTableDialog> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _rowsCtrl = TextEditingController();
  final _colsCtrl = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _rowsCtrl.dispose();
    _colsCtrl.dispose();
    super.dispose();
  }

  void _onInsert() {
    setState(() => _errorText = null);
    final titleText = _titleCtrl.text.trim();
    final descText = _descCtrl.text.trim();
    final rows = int.tryParse(_rowsCtrl.text) ?? 0;
    final cols = int.tryParse(_colsCtrl.text) ?? 0;
    if (titleText.isEmpty) {
      setState(() => _errorText = 'Ingresa un título para la tabla');
      return;
    }
    if (rows <= 0 || cols <= 0) {
      setState(() => _errorText = 'Filas y columnas deben ser mayores que 0');
      return;
    }
    // Genera matriz de celdas vacías
    final data = List.generate(rows, (_) => List.generate(cols, (_) => ''));
    // Crea TextBlocks con formato por defecto
    final titleBlock = TextBlock(
        id: UniqueKey().toString(), text: titleText, format: BlockFormat());
    final descBlock = TextBlock(
        id: UniqueKey().toString(), text: descText, format: BlockFormat());
    // Pop con TableBlock
    Navigator.of(context).pop(
      TableBlock(
        id: UniqueKey().toString(),
        tableTitle: titleBlock,
        description: descBlock,
        rows: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Insert Table',
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Título de la tabla',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _rowsCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Filas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _colsCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Columnas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 10),
              Text(_errorText!, style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: _onInsert,
          child: const Text('Insertar'),
        ),
      ],
    );
  }
}
