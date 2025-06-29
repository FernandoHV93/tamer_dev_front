import 'package:flutter/material.dart';

class ApiSettingsScreen extends StatelessWidget {
  const ApiSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ApiProviderCard(
              providerName: 'OpenAI GPT-4',
              logo: Icons.bubble_chart,
              features: const [
                'Advanced text generation and completion',
                'Natural language understanding',
                'Content summarization and expansion',
                'Multiple language support',
              ],
            ),
            const SizedBox(height: 24),
            _ApiProviderCard(
              providerName: 'Anthropic Claude',
              logo: Icons.brightness_5,
              features: const [
                'Advanced reasoning capabilities',
                'Longer context understanding',
                'Nuanced content generation',
                'Improved factual accuracy',
              ],
            ),
            const SizedBox(height: 24),
            _ApiProviderCard(
              providerName: 'Perplexity',
              logo: Icons.device_hub,
              features: const [
                'State-of-the-art language models',
                'Advanced reasoning capabilities',
                'Contextual understanding',
                'High accuracy responses',
              ],
            ),
            const SizedBox(height: 24),
            _ApiProviderCard(
              providerName: 'Grok',
              logo: Icons.flash_on,
              features: const [
                'Real-time data integration',
                'Advanced reasoning with current context',
                'Witty and informative responses',
                'Tesla-grade AI capabilities',
              ],
            ),
            const SizedBox(height: 32),
            _ApiUsageGuidelinesCard(),
          ],
        ),
      ),
    );
  }
}

class _ApiProviderCard extends StatelessWidget {
  final String providerName;
  final IconData logo;
  final List<String> features;

  const _ApiProviderCard({
    required this.providerName,
    required this.logo,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(logo, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    providerName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Disconnected',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'API Key',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Connect'),
              ),
            ),
            const SizedBox(height: 16),
            Text('Features', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...features.map((f) => Row(
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 18, color: Colors.green),
                    const SizedBox(width: 8),
                    Expanded(child: Text(f)),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class _ApiUsageGuidelinesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('API Usage Guidelines',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            const Text(
              'Your API keys are stored securely in your browser\'s local storage and are only used to authenticate requests to the respective services. We never store or share your API keys with third parties.',
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'API requests are made directly from your browser to the AI providers, ensuring maximum security.')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 18),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'You maintain full control over your API usage and can disconnect at any time.')),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.cancel, color: Colors.red, size: 18),
                SizedBox(width: 8),
                Expanded(
                    child: Text(
                        'Never share your API keys with others or expose them in public repositories.')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
