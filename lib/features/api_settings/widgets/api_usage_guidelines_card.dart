import 'package:flutter/material.dart';

class ApiUsageGuidelinesCard extends StatelessWidget {
  const ApiUsageGuidelinesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('API Usage Guidelines',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(height: 12),
          const Text(
            'Your API keys are stored securely in your browser\'s local storage and are only used to authenticate requests to the respective services. We never store or share your API keys with third parties.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF2D8EFF), size: 18),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                      'API requests are made directly from your browser to the AI providers, ensuring maximum security.',
                      style: TextStyle(color: Colors.white70))),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF2D8EFF), size: 18),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                      'You maintain full control over your API usage and can disconnect at any time.',
                      style: TextStyle(color: Colors.white70))),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: const [
              Icon(Icons.cancel, color: Colors.red, size: 18),
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                      'Never share your API keys with others or expose them in public repositories.',
                      style: TextStyle(color: Colors.white70))),
            ],
          ),
        ],
      ),
    );
  }
}
