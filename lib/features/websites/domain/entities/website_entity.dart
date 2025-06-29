enum WebsiteStatus {
  Active,
  Inactive,
}

class WebsiteEntity {
  final String id;
  final WebsiteStatus status;
  final String url;
  final String name;
  final DateTime? lastChecked;

  WebsiteEntity({
    required this.id,
    required this.status,
    required this.url,
    required this.name,
    this.lastChecked,
  });

  // Método para convertir a Map (útil para Firebase/persistencia)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.name,
      'url': url,
      'name': name,
      'lastChecked': lastChecked?.toIso8601String(),
    };
  }

  // Método para crear objeto desde Map
  factory WebsiteEntity.fromMap(Map<String, dynamic> map) {
    return WebsiteEntity(
      id: map['id'] ?? '',
      status: WebsiteStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => WebsiteStatus.Active,
      ),
      url: map['url'] ?? '',
      name: map['name'] ?? '',
      lastChecked: map['lastChecked'] != null
          ? DateTime.parse(map['lastChecked'])
          : null,
    );
  }

  // Método para copiar con valores modificados
  WebsiteEntity copyWith({
    String? id,
    WebsiteStatus? status,
    String? url,
    String? name,
    DateTime? lastChecked,
  }) {
    return WebsiteEntity(
      id: id ?? this.id,
      status: status ?? this.status,
      url: url ?? this.url,
      name: name ?? this.name,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WebsiteEntity && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'WebsiteEntity(id: $id, name: $name, url: $url, status: $status)';
  }
}
