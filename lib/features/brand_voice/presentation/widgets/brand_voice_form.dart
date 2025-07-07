import 'package:flutter/material.dart';
import 'package:ia_web_front/features/brand_voice/domain/entities/brand_voice_entity.dart';
import 'package:provider/provider.dart';
import '../provider/brand_form_provider.dart';
import '../provider/brand_voice_provider.dart';
import 'package:ia_web_front/core/providers/session_provider.dart';

class BrandVoiceForm extends StatefulWidget {
  const BrandVoiceForm({super.key});

  @override
  State<BrandVoiceForm> createState() => _BrandVoiceFormState();
}

class _BrandVoiceFormState extends State<BrandVoiceForm> {
  final _brandNameController = TextEditingController();
  final _toneOfVoiceController = TextEditingController();
  final _keyValueController = TextEditingController();
  final _targetAudienceController = TextEditingController();
  final _brandIdentityInsightsController = TextEditingController();

  BrandFormProvider? _lastProvider;
  BrandVoice? _lastEditingBrand;

  @override
  void dispose() {
    _brandNameController.dispose();
    _toneOfVoiceController.dispose();
    _keyValueController.dispose();
    _targetAudienceController.dispose();
    _brandIdentityInsightsController.dispose();
    super.dispose();
  }

  void _syncControllersWithProvider(BrandFormProvider provider) {
    if (provider.isEditing && provider.editingBrand != null) {
      final brand = provider.editingBrand!;
      _brandNameController.text = brand.brandName;
      _toneOfVoiceController.text = brand.toneOfVoice;
      _targetAudienceController.text = brand.targetAudience;
      _brandIdentityInsightsController.text = brand.brandIdentityInsights;
    } else {
      _brandNameController.clear();
      _toneOfVoiceController.clear();
      _targetAudienceController.clear();
      _brandIdentityInsightsController.clear();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<BrandFormProvider>(context, listen: false);
    _syncControllersWithProvider(provider);
    _lastProvider = provider;
    _lastEditingBrand = provider.editingBrand;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BrandFormProvider>(
      builder: (context, provider, _) {
        // Si cambia el brand a editar, sincroniza los controllers
        if (_lastEditingBrand != provider.editingBrand) {
          _syncControllersWithProvider(provider);
          _lastEditingBrand = provider.editingBrand;
        }
        return Container(
          margin: const EdgeInsets.only(top: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF23262F),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Brand Voice Preview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Brand Name',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _brandNameController,
                          onChanged: provider.setBrandName,
                          decoration: InputDecoration(
                            hintText: 'Enter brand name...',
                            filled: true,
                            fillColor: const Color(0xFF2C2F3A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.white54),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Tone of Voice',
                            style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _toneOfVoiceController,
                          onChanged: provider.setToneOfVoice,
                          decoration: InputDecoration(
                            hintText: 'Enter tone of voice...',
                            filled: true,
                            fillColor: const Color(0xFF2C2F3A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(color: Colors.white54),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Key Values', style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _keyValueController,
                      onSubmitted: (value) {
                        provider.addKeyValue(value.trim());
                        _keyValueController.clear();
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter key value...',
                        filled: true,
                        fillColor: const Color(0xFF2C2F3A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: const TextStyle(color: Colors.white54),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      provider.addKeyValue(_keyValueController.text.trim());
                      _keyValueController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3A7BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: provider.keyValues.map((kv) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0x803A7BFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kv,
                          style: const TextStyle(
                            color: Color(0xFF3A7BFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => provider.removeKeyValue(kv),
                          child: const Icon(Icons.close,
                              size: 18, color: Color(0xFF3A7BFF)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              const Text('Target Audience',
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              TextField(
                controller: _targetAudienceController,
                onChanged: provider.setTargetAudience,
                decoration: InputDecoration(
                  hintText: 'Business professionals... (Example)',
                  filled: true,
                  fillColor: const Color(0xFF2C2F3A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text('Brand Identity Insights',
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              TextField(
                controller: _brandIdentityInsightsController,
                onChanged: provider.setBrandIdentityInsights,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter Brand Identity Insights...',
                  filled: true,
                  fillColor: const Color(0xFF2C2F3A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Consumer<BrandFormProvider>(
                  builder: (context, provider, _) {
                    final brandVoiceProvider =
                        Provider.of<BrandVoiceProvider>(context, listen: false);
                    final session = SessionProvider.of(context);
                    final sessionId = session.sessionID;
                    final userId = session.userID;
                    return ElevatedButton(
                      onPressed: provider.isFormValid
                          ? () async {
                              if (provider.isEditing) {
                                await provider.saveEdit(
                                  brandVoiceProvider,
                                  sessionId,
                                  userId,
                                );
                              } else {
                                await brandVoiceProvider.addBrand(
                                  sessionId,
                                  userId,
                                  BrandVoice(
                                    id: '',
                                    brandName: provider.brandName,
                                    toneOfVoice: provider.toneOfVoice,
                                    keyValues: provider.keyValues,
                                    targetAudience: provider.targetAudience,
                                    brandIdentityInsights:
                                        provider.brandIdentityInsights,
                                  ),
                                );
                                provider.resetForm();
                              }
                              _brandNameController.clear();
                              _toneOfVoiceController.clear();
                              _keyValueController.clear();
                              _targetAudienceController.clear();
                              _brandIdentityInsightsController.clear();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: provider.isFormValid
                            ? const Color(0xFF3A7BFF)
                            : const Color(0x803A7BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        foregroundColor: provider.isFormValid
                            ? Colors.white
                            : Colors.white54,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Text(
                          provider.isEditing ? 'Save Changes' : 'Add Brand',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: provider.isFormValid
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
