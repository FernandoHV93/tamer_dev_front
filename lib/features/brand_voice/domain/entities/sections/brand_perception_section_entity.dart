class BrandPerceptionSectionEntity {
  final String object;
  final String slogan;
  final String feeling;
  final String afterPurchase;

  BrandPerceptionSectionEntity({
    required this.object,
    required this.slogan,
    required this.feeling,
    required this.afterPurchase,
  });

  factory BrandPerceptionSectionEntity.fromJson(Map<String, dynamic> json) =>
      BrandPerceptionSectionEntity(
        object: json['object'] ?? '',
        slogan: json['slogan'] ?? '',
        feeling: json['feeling'] ?? '',
        afterPurchase: json['afterPurchase'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'object': object,
        'slogan': slogan,
        'feeling': feeling,
        'afterPurchase': afterPurchase,
      };
}
