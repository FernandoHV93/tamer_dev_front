import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provider/brand_voice_provider.dart';

class ContentAnalysisUploadView extends StatefulWidget {
  final VoidCallback onBack;
  final void Function(File file) onAnalyze;

  const ContentAnalysisUploadView({
    super.key,
    required this.onBack,
    required this.onAnalyze,
  });

  @override
  State<ContentAnalysisUploadView> createState() =>
      _ContentAnalysisUploadViewState();
}

class _ContentAnalysisUploadViewState extends State<ContentAnalysisUploadView> {
  File? _selectedFile;
  String? _fileName;
  String? _error;
  static const int maxFileSize = 5 * 1024 * 1024; // 5MB

  Future<void> _pickFile() async {
    setState(() {
      _error = null;
    });
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );
    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      final fileSize = await file.length();
      if (fileSize > maxFileSize) {
        setState(() {
          _selectedFile = null;
          _fileName = null;
          _error = 'File size must be less than 5MB.';
        });
        return;
      }
      setState(() {
        _selectedFile = file;
        _fileName = result.files.single.name;
        _error = null;
      });
    }
  }

  Widget _buildFilePreview() {
    if (_selectedFile == null) return const SizedBox.shrink();
    final ext = _fileName?.split('.').last.toLowerCase();
    String iconAsset;
    if (ext == 'pdf') {
      iconAsset = 'assets/images/icons/pdf.svg';
    } else if (ext == 'doc' || ext == 'docx') {
      iconAsset = 'assets/images/icons/doc.svg';
    } else {
      iconAsset = 'assets/images/icons/text.svg';
    }
    return Column(
      children: [
        SvgPicture.asset(
          iconAsset,
          width: 48,
          height: 48,
          colorFilter:
              const ColorFilter.mode(Color(0xFF2D8EFF), BlendMode.srcIn),
        ),
        const SizedBox(height: 10),
        Text(
          _fileName ?? '',
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final brandVoiceProvider = Provider.of<BrandVoiceProvider>(context);
    final isLoading = brandVoiceProvider.isLoading;
    final providerError = brandVoiceProvider.error;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFF23262F),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blueGrey.shade700, width: 1.2),
          ),
          child: Center(
            child: _selectedFile == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/icons/upload.svg',
                        width: 40,
                        height: 40,
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF2D8EFF), BlendMode.srcIn),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Drag and drop your file here',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      const SizedBox(height: 6),
                      const Text('or', style: TextStyle(color: Colors.white38)),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: isLoading ? null : _pickFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D8EFF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 12),
                        ),
                        child: const Text('Browse Files',
                            style: TextStyle(fontSize: 15)),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Supports PDF, DOC, DOCX, and TXT files',
                        style: TextStyle(color: Colors.white38, fontSize: 13),
                      ),
                    ],
                  )
                : _buildFilePreview(),
          ),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(_error!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 14)),
        ],
        const SizedBox(height: 24),
        Row(
          children: [
            OutlinedButton(
              onPressed: isLoading ? null : widget.onBack,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2D8EFF),
                side: const BorderSide(color: Color(0xFF2D8EFF)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Back'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: (_selectedFile != null && !isLoading)
                  ? () => widget.onAnalyze(_selectedFile!)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: (_selectedFile != null && !isLoading)
                    ? const Color(0xFF2D8EFF)
                    : Colors.blueGrey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Analyze Content'),
            ),
          ],
        ),
        if (providerError != null && providerError.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(providerError,
              style: const TextStyle(color: Colors.redAccent, fontSize: 15)),
        ],
      ],
    );
  }
}
