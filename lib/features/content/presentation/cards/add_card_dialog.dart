import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/content/domain/entities/content_card_entity.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';
import 'package:ia_web_front/features/websites/presentation/controller/websites_provider.dart';

class AddCardDialog extends StatefulWidget {
  final ContentProvider contentProvider;
  final SessionProvider sessionProvider;

  const AddCardDialog({
    super.key,
    required this.contentProvider,
    required this.sessionProvider,
  });

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  final TextEditingController cardNameController = TextEditingController();
  ContentCardStatus _selectedStatus = ContentCardStatus.done;
  String? _selectedWebsiteId;

  @override
  void initState() {
    super.initState();
    _selectedWebsiteId = widget.contentProvider.selectedWebsiteId;
  }

  @override
  Widget build(BuildContext context) {
    final websitesProvider =
        Provider.of<WebsitesProvider>(context, listen: false);
    final websites = websitesProvider.websites;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add New Card',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Card Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Choose a descriptive name for your content topic',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cardNameController,
              decoration: InputDecoration(
                hintText: 'e.g., SEO Best Practices',
                hintStyle: const TextStyle(color: Colors.black38),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF1757DF), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Select the status for this content card',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ContentCardStatus>(
              value: _selectedStatus,
              items: ContentCardStatus.values.map((status) {
                return DropdownMenuItem<ContentCardStatus>(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF1757DF), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Associated Website',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Select a website to associate this card with',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedWebsiteId,
              items: websites.map((website) {
                return DropdownMenuItem<String>(
                  value: website.id,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 8),
                      Text(website.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedWebsiteId = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF1757DF), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ModernDialogButton(
                  text: 'Cancel',
                  isPrimary: false,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 5),
                _ModernDialogButton(
                  text: 'Add Card',
                  isPrimary: true,
                  onPressed: () async {
                    if (cardNameController.text.isNotEmpty &&
                        _selectedWebsiteId != null) {
                      // Buscar la URL del website seleccionado
                      final selectedWebsite = websites.firstWhere(
                        (w) => w.id == _selectedWebsiteId,
                        orElse: () => throw Exception('Website not found'),
                      );
                      final newCard = ContentCardEntity(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        websiteId: _selectedWebsiteId!,
                        title: cardNameController.text,
                        url: selectedWebsite
                            .url, // Asigna la url del website seleccionado
                        keyWordsScore: 0,
                        status: _selectedStatus,
                      );
                      await widget.contentProvider.addContentCard(
                        newCard,
                        widget.sessionProvider.sessionID,
                        widget.sessionProvider.userID,
                      );

                      if (mounted) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Card added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please enter a card name and select a website'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cardNameController.dispose();
    super.dispose();
  }
}

// Botón moderno reutilizable
class _ModernDialogButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;
  const _ModernDialogButton(
      {required this.text, required this.isPrimary, required this.onPressed});
  @override
  State<_ModernDialogButton> createState() => _ModernDialogButtonState();
}

class _ModernDialogButtonState extends State<_ModernDialogButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.isPrimary ? const Color(0xFF1757DF) : Colors.white;
    final textColor = widget.isPrimary ? Colors.white : const Color(0xFF1757DF);
    final borderColor =
        widget.isPrimary ? const Color(0xFF1757DF) : const Color(0xFFE5E7EB);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hovered
              ? (widget.isPrimary
                  ? const Color(0xFF1746B3)
                  : const Color(0xFFF3F4F6))
              : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: _hovered && widget.isPrimary
              ? [
                  BoxShadow(
                      color: const Color(0x331757DF),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: widget.isPrimary
                ? Colors.white24
                : const Color(0xFF1757DF).withOpacity(0.08),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
