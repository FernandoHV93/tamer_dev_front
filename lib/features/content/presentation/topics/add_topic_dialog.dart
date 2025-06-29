import 'package:flutter/material.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'package:ia_web_front/features/content/domain/entities/topic_entity.dart';
import 'package:ia_web_front/features/content/presentation/controller/content_provider.dart';

class AddTopicDialog extends StatefulWidget {
  final ContentProvider contentProvider;
  final SessionProvider sessionProvider;
  final String cardId;

  const AddTopicDialog({
    super.key,
    required this.contentProvider,
    required this.sessionProvider,
    required this.cardId,
  });

  @override
  State<AddTopicDialog> createState() => _AddTopicDialogState();
}

class _AddTopicDialogState extends State<AddTopicDialog>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _keyWordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _keyWordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Topic',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _keyWordController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter topic title',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a topic title';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            _ModernDialogButton(
              text: 'Cancel',
              isPrimary: false,
              onPressed: () => Navigator.of(context).pop(),
            ),
            _ModernDialogButton(
              text: 'Add Topic',
              isPrimary: true,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final newTopic = TopicEntity(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    cardId: widget.cardId,
                    keyWord: _keyWordController.text,
                    date: DateTime.now().toIso8601String().split('T')[0],
                    status: TopicStatus.initiated,
                  );

                  await widget.contentProvider.addTopic(
                    newTopic,
                    widget.sessionProvider.sessionID,
                    widget.sessionProvider.userID,
                  );

                  if (mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Topic added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
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
