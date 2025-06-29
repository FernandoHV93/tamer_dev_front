import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final String? text;
  final double size;
  const LoadingIndicator({Key? key, this.text, this.size = 36})
      : super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            turns: _controller,
            child: Icon(
              Icons.sync,
              size: widget.size,
              color: const Color(0xFF1757DF),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.text ?? 'Loading...',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1757DF),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
