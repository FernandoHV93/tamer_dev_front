import 'package:flutter/material.dart';
import 'package:ia_web_front/features/brand_voice/data/repository/brand_voice_repository_impl.dart';
import 'package:provider/provider.dart';
import 'provider/brand_voice_provider.dart';
import 'widgets/brand_voice_method_card.dart';
import 'widgets/brand_voice_content_analysis_container.dart';
import 'provider/brand_form_provider.dart';
import 'widgets/brand_voice_form.dart';
import 'widgets/brand_voice_table.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';
import 'widgets/deep_analysis_stepper.dart';
import 'provider/deep_analysis_wizard_provider.dart';
import 'package:ia_web_front/features/brand_voice/domain/usecases/brand_voice_usecases.dart';

class BrandVoiceScreen extends StatefulWidget {
  const BrandVoiceScreen({super.key});

  @override
  State<BrandVoiceScreen> createState() => _BrandVoiceScreenState();
}

class _BrandVoiceScreenState extends State<BrandVoiceScreen> {
  bool _brandsLoaded = false;
  final ScrollController _mainScrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_brandsLoaded) {
      final sessionProvider = SessionProvider.of(context);
      final brandProvider =
          Provider.of<BrandVoiceProvider>(context, listen: false);
      brandProvider.loadBrands(
          sessionProvider.sessionID, sessionProvider.userID);
      _brandsLoaded = true;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandVoiceProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF181A20),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: SingleChildScrollView(
                  controller: _mainScrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Brand Voice',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Tooltip(
                            message:
                                'Define and analyze your brand voice for consistent content.',
                            child: Icon(Icons.help_outline,
                                color: Colors.blue[200], size: 22),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF23262F),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Choose Your Method',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: BrandVoiceMethodCard(
                                    title: 'DEEP',
                                    description:
                                        'A comprehensive and challenging process designed for those who truly want to make a difference with their content.',
                                    selected: provider.selectedMethod ==
                                        BrandVoiceMethod.deep,
                                    recommended: true,
                                    badgeText: 'Most Valuable Way',
                                    onTap: () => provider
                                        .selectMethod(BrandVoiceMethod.deep),
                                    iconPath: 'assets/images/icons/docs.svg',
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: BrandVoiceMethodCard(
                                    title: 'Content Analysis',
                                    description:
                                        'Let us analyze your existing content to extract your brand voice patterns.',
                                    selected: provider.selectedMethod ==
                                        BrandVoiceMethod.contentAnalysis,
                                    recommended: false,
                                    onTap: () => provider.selectMethod(
                                        BrandVoiceMethod.contentAnalysis),
                                    iconPath: 'assets/images/icons/files.svg',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      if (provider.selectedMethod ==
                          BrandVoiceMethod.contentAnalysis)
                        const BrandVoiceContentAnalysisContainer(),
                      if (provider.selectedMethod == BrandVoiceMethod.deep &&
                          !Provider.of<BrandFormProvider>(context)
                              .isEditingFromWizard)
                        ChangeNotifierProvider(
                          create: (context) {
                            final wizardProvider = DeepAnalysisWizardProvider(
                              BrandVoiceUseCases(BrandVoiceRepositoryImpl()),
                              brandVoiceProvider:
                                  Provider.of<BrandVoiceProvider>(context,
                                      listen: false),
                            );
                            // Limpiar wizard y formulario al seleccionar deep
                            wizardProvider.clearWizard();
                            Provider.of<BrandFormProvider>(context,
                                    listen: false)
                                .resetForm();
                            return wizardProvider;
                          },
                          child: DeepAnalysisStepper(
                              scrollController: _mainScrollController),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandVoiceForm(),
                          Consumer2<BrandVoiceProvider, BrandFormProvider>(
                            builder: (context, brandProvider, formProvider, _) {
                              final sessionProvider =
                                  SessionProvider.of(context);
                              return BrandVoiceTable(
                                brands: brandProvider.savedBrands,
                                isLoading: brandProvider.isLoading,
                                error: brandProvider.error,
                                onEdit: (brand) {
                                  formProvider.setEditingBrand(brand);
                                },
                                onDelete: (brand) async {
                                  await brandProvider.deleteBrand(
                                    sessionProvider.sessionID,
                                    sessionProvider.userID,
                                    brand.id,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
