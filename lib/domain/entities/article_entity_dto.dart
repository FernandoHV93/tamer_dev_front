class ArticleDto {
  final String userID;
  final String sessionID;
  final TextFormatDto h1;
  final List<BodySectionDto> body;

  ArticleDto({
    required this.userID,
    required this.sessionID,
    required this.h1,
    required this.body,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) => ArticleDto(
        userID: json['userID'],
        sessionID: json['sessionID'],
        h1: TextFormatDto.fromJson(json['H1']),
        body: (json['body'] as List)
            .map((e) => BodySectionDto.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'sessionID': sessionID,
        'H1': h1.toJson(),
        'body': body.map((e) => e.toJson()).toList(),
      };
}

class BodySectionDto {
  final TextFormatDto title;
  final List<TableDto> tables;
  final List<TextFormatDto> text;
  final List<ImageDto> images;
  final List<CodeDto> codes;
  final List<LinkDto> links;
  final List<CitationDto> citations;

  BodySectionDto({
    required this.title,
    required this.tables,
    required this.text,
    required this.images,
    required this.codes,
    required this.links,
    required this.citations,
  });

  factory BodySectionDto.fromJson(Map<String, dynamic> json) => BodySectionDto(
        title: TextFormatDto.fromJson(json['title']),
        tables:
            (json['tables'] as List).map((e) => TableDto.fromJson(e)).toList(),
        text: (json['text'] as List)
            .map((e) => TextFormatDto.fromJson(e))
            .toList(),
        images:
            (json['images'] as List).map((e) => ImageDto.fromJson(e)).toList(),
        codes: (json['codes'] as List).map((e) => CodeDto.fromJson(e)).toList(),
        links: (json['links'] as List).map((e) => LinkDto.fromJson(e)).toList(),
        citations: (json['citations'] as List)
            .map((e) => CitationDto.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'title': title.toJson(),
        'tables': tables.map((e) => e.toJson()).toList(),
        'text': text.map((e) => e.toJson()).toList(),
        'images': images.map((e) => e.toJson()).toList(),
        'codes': codes.map((e) => e.toJson()).toList(),
        'links': links.map((e) => e.toJson()).toList(),
        'citations': citations.map((e) => e.toJson()).toList(),
      };
}

class TextFormatDto {
  final bool N;
  final bool I;
  final bool U;
  final String text;
  final String aligment;
  final String size;

  TextFormatDto({
    required this.N,
    required this.I,
    required this.U,
    required this.text,
    required this.aligment,
    required this.size,
  });

  factory TextFormatDto.fromJson(Map<String, dynamic> json) => TextFormatDto(
        N: json['N'],
        I: json['I'],
        U: json['U'],
        text: json['text'],
        aligment: json['aligment'],
        size: json['size'],
      );

  Map<String, dynamic> toJson() => {
        'N': N,
        'I': I,
        'U': U,
        'text': text,
        'aligment': aligment,
        'size': size,
      };
}

class TableDto {
  final List<List<TextFormatDto>> rows;
  final List<TextFormatDto> columns;
  final TextFormatDto tableTitle;
  final TextFormatDto description;

  TableDto(
      {required this.rows,
      required this.columns,
      required this.description,
      required this.tableTitle});

  factory TableDto.fromJson(Map<String, dynamic> json) => TableDto(
        rows: (json['rows'] as List)
            .map((row) => (row as List)
                .map((cell) => TextFormatDto.fromJson(cell))
                .toList())
            .toList(),
        columns: (json['columns'] as List)
            .map((e) => TextFormatDto.fromJson(e))
            .toList(),
        tableTitle: TextFormatDto.fromJson(json['title']),
        description: TextFormatDto.fromJson(json['description']),
      );

  Map<String, dynamic> toJson() => {
        'rows': rows.map((row) => row.map((e) => e.toJson()).toList()).toList(),
        'columns': columns.map((e) => e.toJson()).toList(),
      };
}

class ImageDto extends TextFormatDto {
  final String url;
  final bool isImage;
  final Map<String, dynamic> properties;

  ImageDto({
    required super.N,
    required super.I,
    required super.U,
    required super.text,
    required super.aligment,
    required super.size,
    required this.url,
    required this.properties,
    required this.isImage,
  });

  factory ImageDto.fromJson(Map<String, dynamic> json) => ImageDto(
        N: json['N'],
        I: json['I'],
        U: json['U'],
        text: json['text'],
        aligment: json['aligment'],
        size: json['size'],
        url: json['url'],
        isImage: json['isImage'],
        properties: Map<String, dynamic>.from(json['properties']),
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'url': url,
        'properties': properties,
      };
}

class CodeDto extends TextFormatDto {
  final String code;

  CodeDto({
    required super.N,
    required super.I,
    required super.U,
    required super.text,
    required super.aligment,
    required super.size,
    required this.code,
  });

  factory CodeDto.fromJson(Map<String, dynamic> json) => CodeDto(
        N: json['N'],
        I: json['I'],
        U: json['U'],
        text: json['text'],
        aligment: json['aligment'],
        size: json['size'],
        code: json['code'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'code': code,
      };
}

class LinkDto extends TextFormatDto {
  final String url;

  LinkDto({
    required super.N,
    required super.I,
    required super.U,
    required super.text,
    required super.aligment,
    required super.size,
    required this.url,
  });

  factory LinkDto.fromJson(Map<String, dynamic> json) => LinkDto(
        N: json['N'],
        I: json['I'],
        U: json['U'],
        text: json['text'],
        aligment: json['aligment'],
        size: json['size'],
        url: json['url'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'url': url,
      };
}

class CitationDto extends TextFormatDto {
  final String citation;

  CitationDto({
    required super.N,
    required super.I,
    required super.U,
    required super.text,
    required super.aligment,
    required super.size,
    required this.citation,
  });

  factory CitationDto.fromJson(Map<String, dynamic> json) => CitationDto(
        N: json['N'],
        I: json['I'],
        U: json['U'],
        text: json['text'],
        aligment: json['aligment'],
        size: json['size'],
        citation: json['citation'],
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'citation': citation,
      };
}
