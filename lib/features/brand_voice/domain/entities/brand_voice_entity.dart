class BrandVoice {
  final String id;
  final String brandName;
  final String toneOfVoice;
  final List<String> keyValues;
  final String targetAudience;
  final String brandIdentityInsights;

  BrandVoice({
    required this.id,
    required this.brandName,
    required this.toneOfVoice,
    required this.keyValues,
    required this.targetAudience,
    required this.brandIdentityInsights,
  });

  BrandVoice copyWith({
    String? id,
    String? brandName,
    String? toneOfVoice,
    List<String>? keyValues,
    String? targetAudience,
    String? brandIdentityInsights,
  }) {
    return BrandVoice(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      toneOfVoice: toneOfVoice ?? this.toneOfVoice,
      keyValues: keyValues ?? List<String>.from(this.keyValues),
      targetAudience: targetAudience ?? this.targetAudience,
      brandIdentityInsights:
          brandIdentityInsights ?? this.brandIdentityInsights,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'brandName': brandName,
        'toneOfVoice': toneOfVoice,
        'keyValues': keyValues,
        'targetAudience': targetAudience,
        'brandIdentityInsights': brandIdentityInsights,
      };

  factory BrandVoice.fromJson(Map<String, dynamic> json) => BrandVoice(
        id: json['id'] ?? '',
        brandName: json['brandName'] ?? '',
        toneOfVoice: json['toneOfVoice'] ?? '',
        keyValues: List<String>.from(json['keyValues'] ?? []),
        targetAudience: json['targetAudience'] ?? '',
        brandIdentityInsights: json['brandIdentityInsights'] ?? '',
      );
}
