class BrandPersonalitySectionEntity {
  final List<String?> dropdownValues;
  final String brandAsPerson;
  final String brandAsFamous;

  BrandPersonalitySectionEntity({
    required this.dropdownValues,
    required this.brandAsPerson,
    required this.brandAsFamous,
  });

  factory BrandPersonalitySectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandPersonalitySectionEntity(
        dropdownValues: (json['dropdownValues'] as List<dynamic>?)
                ?.map((e) => e as String?)
                .toList() ??
            List.filled(8, null),
        brandAsPerson: json['brandAsPerson'] ?? '',
        brandAsFamous: json['brandAsFamous'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'dropdownValues': dropdownValues,
        'brandAsPerson': brandAsPerson,
        'brandAsFamous': brandAsFamous,
      };
}
