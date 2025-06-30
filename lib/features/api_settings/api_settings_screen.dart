import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiSettingsScreen extends StatelessWidget {
  const ApiSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('API Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ApiProviderCard(
              providerName: 'OpenAI GPT-4',
              logoUrl:
                  'https://seeklogo.com/images/O/openai-logo-8B9BFEDC26-seeklogo.com.png',
              description:
                  "Connect to OpenAI's GPT-4 for state-of-the-art language processing and content generation. ",
              learnUrl: 'https://platform.openai.com/api-keys',
              features: const [
                'Advanced text generation and completion',
                'Natural language understanding',
                'Content summarization and expansion',
                'Multiple language support',
              ],
            ),
            const SizedBox(height: 32),
            _ApiProviderCard(
              providerName: 'Anthropic Claude',
              logoUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/7/7a/Anthropic_logo.png',
              description:
                  "Integrate with Anthropic's Claude for enhanced AI capabilities and sophisticated content generation.",
              learnUrl:
                  'https://docs.anthropic.com/claude/docs/quickstart-guide',
              features: const [
                'Advanced reasoning capabilities',
                'Longer context understanding',
                'Nuanced content generation',
                'Improved factual accuracy',
              ],
            ),
            const SizedBox(height: 32),
            _ApiProviderCard(
              providerName: 'Perplexity',
              logoUrl:
                  'https://seeklogo.com/images/P/perplexity-ai-logo-8E8F5C6C7B-seeklogo.com.png',
              description:
                  "Connect to Perplexity AI for advanced language understanding and generation.",
              learnUrl: 'https://docs.perplexity.ai/docs/api-keys',
              features: const [
                'State-of-the-art language models',
                'Advanced reasoning capabilities',
                'Contextual understanding',
                'High accuracy responses',
              ],
            ),
            const SizedBox(height: 32),
            _ApiProviderCard(
              providerName: 'Grok',
              logoUrl:
                  'https://pbs.twimg.com/profile_images/1724894470119022592/0QbQKp2A_400x400.jpg',
              description:
                  "Connect to Tesla's Grok AI for cutting-edge language processing and real-time analysis.",
              learnUrl: 'https://x.ai/',
              features: const [
                'Real-time data integration',
                'Advanced reasoning with current context',
                'Witty and informative responses',
                'Tesla-grade AI capabilities',
              ],
            ),
            const SizedBox(height: 40),
            _ApiUsageGuidelinesCard(),
          ],
        ),
      ),
    );
  }
}

class _ApiProviderCard extends StatelessWidget {
  final String providerName;
  final String logoUrl;
  final String description;
  final String learnUrl;
  final List<String> features;

  const _ApiProviderCard({
    required this.providerName,
    required this.logoUrl,
    required this.description,
    required this.learnUrl,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23262F),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo placeholder
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D8EFF),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 18),
              // Expanded for title, disconnected, description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          providerName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Text(
                            'Disconnected',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Descripción + link azul
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (await canLaunchUrl(Uri.parse(learnUrl))) {
                              await launchUrl(Uri.parse(learnUrl),
                                  mode: LaunchMode.externalApplication);
                            }
                          },
                          child: const Text(
                            'Learn how to get your API key →',
                            style: TextStyle(
                              color: Color(0xFF4FC3F7),
                              fontSize: 14,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // BODY
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // API Key column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'API Key',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF181A20),
                        hintText: 'Enter your API key',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon:
                            Icon(Icons.visibility, color: Colors.grey[400]),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D8EFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Connect',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 48),
              // Features column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 18),
                    ...features.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: const Color(0xFF2D8EFF), size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  f,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
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
      color: const Color(0xFF23262F),
      child: Padding(
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
      ),
    );
  }
}
