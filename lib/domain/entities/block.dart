import 'dart:ui';

class Block {
  String id;
  Offset position;
  String title;
  List<String> comments;
  List<String> links;
  String label;
  Map<String, String> context;

  Block({
    required this.id,
    required this.position,
    required this.title,
    this.comments = const [],
    this.links = const [],
    this.label = "Done",
    this.context = const {"context": ""},
  });
}
