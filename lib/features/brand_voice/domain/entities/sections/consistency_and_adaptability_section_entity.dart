class ConsistencyAndAdaptabilitySectionEntity {
  final String consistency;
  final String guidelines;
  final String adapt;

  ConsistencyAndAdaptabilitySectionEntity({
    required this.consistency,
    required this.guidelines,
    required this.adapt,
  });

  factory ConsistencyAndAdaptabilitySectionEntity.fromJson(
          Map<String, dynamic> json) =>
      ConsistencyAndAdaptabilitySectionEntity(
        consistency: json['consistency'] ?? '',
        guidelines: json['guidelines'] ?? '',
        adapt: json['adapt'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'consistency': consistency,
        'guidelines': guidelines,
        'adapt': adapt,
      };
}
