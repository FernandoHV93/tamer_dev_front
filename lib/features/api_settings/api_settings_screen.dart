import 'package:flutter/material.dart';
import 'package:ia_web_front/core/desing/app_constant.dart';
import 'package:ia_web_front/features/api_settings/widgets/api_provider_card.dart';
import 'package:ia_web_front/features/api_settings/widgets/api_usage_guidelines_card.dart';
import 'package:provider/provider.dart';
import 'package:ia_web_front/features/api_settings/presentation/provider/api_settings_provider.dart';
import 'package:ia_web_front/features/api_settings/data/repository/api_settings_repository_impl.dart';
import 'package:ia_web_front/features/api_settings/domain/usecases/api_settings_usecases.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';

class ApiSettingsScreen extends StatelessWidget {
  const ApiSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionProvider = SessionProvider.of(context);
    final String sessionId = sessionProvider.sessionID;
    final String userId = sessionProvider.userID;

    return ChangeNotifierProvider<ApiSettingsProvider>(
      create: (_) => ApiSettingsProvider(
        useCases: ApiSettingsUseCases(ApiSettingsRepositoryImpl()),
      )..loadProvidersStatus(sessionId, userId),
      child: Consumer<ApiSettingsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xFF181A20),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppConstants.kArticleBuilderMaxWidth,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'API Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Connect your OpenAI and Anthropic API keys to unlock advanced AI capabilities.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 32),
                        ],
                      ),
                      ApiProviderCard(
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
                        isConnected:
                            provider.providersStatus['OpenAI GPT-4'] ?? false,
                        onConnect: (apiKey) async {
                          final success = await provider.connectProvider(
                              sessionId, userId, apiKey, 'OpenAI GPT-4');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Connected to OpenAI GPT-4!'),
                                  backgroundColor: Colors.green),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['OpenAI GPT-4'] ??
                                          'Connection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        onDisconnect: () async {
                          final success = await provider.disconnectProvider(
                              sessionId, userId, 'OpenAI GPT-4');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Disconnected from OpenAI GPT-4!'),
                                  backgroundColor: Colors.orange),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['OpenAI GPT-4'] ??
                                          'Disconnection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        isLoading:
                            provider.loadingByProvider['OpenAI GPT-4'] ?? false,
                        error: provider.providerErrors['OpenAI GPT-4'],
                      ),
                      const SizedBox(height: 32),
                      ApiProviderCard(
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
                        isConnected:
                            provider.providersStatus['Anthropic Claude'] ??
                                false,
                        onConnect: (apiKey) async {
                          final success = await provider.connectProvider(
                              sessionId, userId, apiKey, 'Anthropic Claude');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Connected to Anthropic Claude!'),
                                  backgroundColor: Colors.green),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(provider
                                          .providerErrors['Anthropic Claude'] ??
                                      'Connection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        onDisconnect: () async {
                          final success = await provider.disconnectProvider(
                              sessionId, userId, 'Anthropic Claude');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Disconnected from Anthropic Claude!'),
                                  backgroundColor: Colors.orange),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(provider
                                          .providerErrors['Anthropic Claude'] ??
                                      'Disconnection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        isLoading:
                            provider.loadingByProvider['Anthropic Claude'] ??
                                false,
                        error: provider.providerErrors['Anthropic Claude'],
                      ),
                      const SizedBox(height: 32),
                      ApiProviderCard(
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
                        isConnected:
                            provider.providersStatus['Perplexity'] ?? false,
                        onConnect: (apiKey) async {
                          final success = await provider.connectProvider(
                              sessionId, userId, apiKey, 'Perplexity');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Connected to Perplexity!'),
                                  backgroundColor: Colors.green),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['Perplexity'] ??
                                          'Connection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        onDisconnect: () async {
                          final success = await provider.disconnectProvider(
                              sessionId, userId, 'Perplexity');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Disconnected from Perplexity!'),
                                  backgroundColor: Colors.orange),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['Perplexity'] ??
                                          'Disconnection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        isLoading:
                            provider.loadingByProvider['Perplexity'] ?? false,
                        error: provider.providerErrors['Perplexity'],
                      ),
                      const SizedBox(height: 32),
                      ApiProviderCard(
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
                        isConnected: provider.providersStatus['Grok'] ?? false,
                        onConnect: (apiKey) async {
                          final success = await provider.connectProvider(
                              sessionId, userId, apiKey, 'Grok');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Connected to Grok!'),
                                  backgroundColor: Colors.green),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['Grok'] ??
                                          'Connection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        onDisconnect: () async {
                          final success = await provider.disconnectProvider(
                              sessionId, userId, 'Grok');
                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Disconnected from Grok!'),
                                  backgroundColor: Colors.orange),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      provider.providerErrors['Grok'] ??
                                          'Disconnection failed'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        },
                        isLoading: provider.loadingByProvider['Grok'] ?? false,
                        error: provider.providerErrors['Grok'],
                      ),
                      const SizedBox(height: 40),
                      const ApiUsageGuidelinesCard(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
