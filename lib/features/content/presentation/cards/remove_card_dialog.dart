import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RemoveCardDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const RemoveCardDialog({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return _AnimatedDialog(
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: SizedBox(
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/warning.svg',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Delete Card',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you sure you want to delete this Card? This action cannot be undone',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'All content and metrics associated with this topic will be permanently removed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _ModernDialogButton(
                    text: 'Cancel',
                    isPrimary: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(width: 5),
                  _ModernDialogButton(
                    text: 'Delete Card',
                    isPrimary: true,
                    isDestructive: true,
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedDialog extends StatefulWidget {
  final Widget child;
  const _AnimatedDialog({required this.child});
  @override
  State<_AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<_AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}

// Botón moderno reutilizable
class _ModernDialogButton extends StatefulWidget {
  final String text;
  final bool isPrimary;
  final bool isDestructive;
  final VoidCallback onPressed;
  const _ModernDialogButton(
      {required this.text,
      required this.isPrimary,
      this.isDestructive = false,
      required this.onPressed});
  @override
  State<_ModernDialogButton> createState() => _ModernDialogButtonState();
}

class _ModernDialogButtonState extends State<_ModernDialogButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final color = widget.isDestructive
        ? const Color(0xFFBE0707)
        : (widget.isPrimary ? const Color(0xFF1757DF) : Colors.white);
    final textColor = widget.isDestructive
        ? Colors.white
        : (widget.isPrimary ? Colors.white : const Color(0xFF1757DF));
    final borderColor = widget.isDestructive
        ? const Color(0xFFBE0707)
        : (widget.isPrimary
            ? const Color(0xFF1757DF)
            : const Color(0xFFE5E7EB));
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: _hovered
              ? (widget.isDestructive
                  ? const Color(0xFF8B0505)
                  : (widget.isPrimary
                      ? const Color(0xFF1746B3)
                      : const Color(0xFFF3F4F6)))
              : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: _hovered && (widget.isPrimary || widget.isDestructive)
              ? [
                  BoxShadow(
                    color: (widget.isDestructive
                        ? const Color(0x33BE0707)
                        : const Color(0x331757DF)),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: widget.isDestructive
                ? Colors.white24
                : (widget.isPrimary
                    ? Colors.white24
                    : const Color(0xFF1757DF).withOpacity(0.08)),
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
