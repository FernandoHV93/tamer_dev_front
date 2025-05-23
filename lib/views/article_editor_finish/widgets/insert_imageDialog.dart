import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ia_web_front/data/models/article_editor_models.dart';

class InsertImageDialog extends StatefulWidget {
  const InsertImageDialog({Key? key}) : super(key: key);

  @override
  _InsertImageDialogState createState() => _InsertImageDialogState();
}

class _InsertImageDialogState extends State<InsertImageDialog> {
  String _mode = 'online';
  final _urlCtrl = TextEditingController();
  final _captionCtrl = TextEditingController();
  final _widthCtrl = TextEditingController(text: '200');
  final _heightCtrl = TextEditingController(text: '200');
  Uint8List? _localBytes;
  String? _localName;
  String? _errorText;

  @override
  void dispose() {
    _urlCtrl.dispose();
    _captionCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  void _pickLocalImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _localBytes = result.files.single.bytes;
        _localName = result.files.single.name;
        _errorText = null;
      });
    }
  }

  void _onInsert() {
    setState(() {
      _errorText = null;
    });

    final width = int.tryParse(_widthCtrl.text);
    final height = int.tryParse(_heightCtrl.text);
    if (width == null || height == null || width <= 0 || height <= 0) {
      setState(() {
        _errorText = 'Ancho y alto deben ser números positivos';
      });
      return;
    }

    if (_mode == 'online') {
      if (_urlCtrl.text.isEmpty) {
        setState(() {
          _errorText = 'Ingresa una URL válida';
        });
        return;
      }
      final uri = Uri.tryParse(_urlCtrl.text);
      if (uri == null || (!uri.hasScheme)) {
        setState(() {
          _errorText = 'URL inválida';
        });
        return;
      }
      Navigator.of(context).pop(
        ImageBlock(
          id: UniqueKey().toString(),
          url: _urlCtrl.text,
          bytes: null,
          text: _captionCtrl.text,
          width: width,
          height: height,
        ),
      );
    } else {
      if (_localBytes == null) {
        setState(() {
          _errorText = 'Selecciona una imagen local';
        });
        return;
      }
      Navigator.of(context).pop(
        ImageBlock(
          id: UniqueKey().toString(),
          url: "",
          bytes: _localBytes,
          text: _captionCtrl.text,
          width: width,
          height: height,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: const [
          Icon(Icons.image, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text('Insertar Imagen',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selector de modo
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                children: [
                  Radio<String>(
                    value: 'online',
                    groupValue: _mode,
                    onChanged: (val) => setState(() => _mode = val!),
                  ),
                  const Text('Online'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'local',
                    groupValue: _mode,
                    onChanged: (val) => setState(() => _mode = val!),
                  ),
                  const Text('Local'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Entrada según modo
            if (_mode == 'online') ...[
              TextField(
                controller: _urlCtrl,
                decoration: const InputDecoration(
                  labelText: 'URL de la imagen',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (_mode == 'local') ...[
              ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Seleccionar imagen local'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _pickLocalImage,
              ),
              if (_localBytes != null) ...[
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(_localBytes!,
                      height: 120, fit: BoxFit.cover),
                ),
                const SizedBox(height: 4),
                Text(
                  _localName ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
            // Caption
            const SizedBox(height: 10),
            TextField(
              controller: _captionCtrl,
              decoration: const InputDecoration(
                labelText: 'Caption',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
            const SizedBox(height: 10),
            // Width & Height
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _widthCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Ancho',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _heightCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Alto',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            // Mostrar error
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
          child: const Text('Cancelar'),
        ),
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
