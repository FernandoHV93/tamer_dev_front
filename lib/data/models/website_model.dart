enum WebsiteStatus {
  Active,
  Inactive,
}

class Website {
  final WebsiteStatus status;
  final String url;
  final String name;
  final DateTime lastChecked;

  Website({
    required this.status,
    required this.url,
    required this.name,
    required this.lastChecked,
  });

  // Método para convertir a Map (útil para Firebase/persistencia)
  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'url': url,
      'name': name,
      'lastChecked': lastChecked.toIso8601String(),
    };
  }

  // Método para crear objeto desde Map
  factory Website.fromMap(Map<String, dynamic> map) {
    return Website(
      status: WebsiteStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => WebsiteStatus.Active,
      ),
      url: map['url'] ?? '',
      name: map['name'] ?? '',
      lastChecked: DateTime.parse(map['lastChecked']),
    );
  }

  // Método para copiar con valores modificados (opcional)
  Website copyWith({
    WebsiteStatus? status,
    String? url,
    String? name,
    DateTime? lastChecked,
  }) {
    return Website(
      status: status ?? this.status,
      url: url ?? this.url,
      name: name ?? this.name,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }
}
