class ImplementationSectionEntity {
  final String instagramVsBlog;
  final String negativeComment;
  final String dosDonts;
  final String customerJourney;

  ImplementationSectionEntity({
    required this.instagramVsBlog,
    required this.negativeComment,
    required this.dosDonts,
    required this.customerJourney,
  });

  factory ImplementationSectionEntity.fromJson(Map<String, dynamic> json) =>
      ImplementationSectionEntity(
        instagramVsBlog: json['instagramVsBlog'] ?? '',
        negativeComment: json['negativeComment'] ?? '',
        dosDonts: json['dosDonts'] ?? '',
        customerJourney: json['customerJourney'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'instagramVsBlog': instagramVsBlog,
        'negativeComment': negativeComment,
        'dosDonts': dosDonts,
        'customerJourney': customerJourney,
      };
}
