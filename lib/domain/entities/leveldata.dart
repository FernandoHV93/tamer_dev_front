class NivelData {
  String title;
  bool expanded;
  List<String> childTitles;
  String? parentId; // padre seleccionado

  NivelData({
    required this.title,
    this.expanded = true,
    this.childTitles = const [],
    this.parentId,
  });
}
