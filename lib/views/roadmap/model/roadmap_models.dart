import 'dart:ui';

class Block {
  String id;
  Offset position;
  String title;
  List<String> comments;
  List<String> links;
  String label;
  Map<String, dynamic> context;
  Block? parentId;
  List<Connection> connections;

  bool get isRoot => parentId == null;

  Block({
    required this.id,
    required this.position,
    required this.title,
    List<String>? comments,
    List<String>? links,
    String? label,
    Map<String, dynamic>? context,
    this.parentId,
    List<Connection>? connections,
  }) : comments = comments ?? [],
       links = links ?? [],
       label = label ?? "Done",
       context = context ?? {},
       connections = List.from(connections ?? []);

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      id: json['id'],
      position: Offset(json['position']['dx'], json['position']['dy']),
      title: json['title'],
      comments: List<String>.from(json['comments']),
      links: List<String>.from(json['links']),
      label: json['label'],
      context: Map<String, dynamic>.from(json['context']),
      parentId: json['parentId'],
      connections:
          (json['connections'] as List<dynamic>?)
              ?.map((c) => Connection.fromJson(c))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': {'dx': position.dx, 'dy': position.dy},
      'title': title,
      'comments': comments,
      'links': links,
      'label': label,
      'context': context,
      'parentId': parentId,
      'connections': connections.map((c) => c.toJson()).toList(),
    };
  }
}

class Connection {
  String fromId;
  String toId;

  Connection({required this.fromId, required this.toId});

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(fromId: json['fromId'], toId: json['toId']);
  }

  Map<String, dynamic> toJson() {
    return {'fromId': fromId, 'toId': toId};
  }
}

class NivelData {
  final String title;
  bool expanded;
  String? parentId; // solo se usa en nivel 1 (opcional)
  Map<String, List<String>> childrenPerParent;

  NivelData({
    required this.title,
    this.expanded = true,
    this.parentId,
    Map<String, List<String>>? childrenPerParent,
  }) : childrenPerParent = childrenPerParent ?? {};
}
