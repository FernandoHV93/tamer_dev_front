import 'package:ia_web_front/data/models/models.dart';
import 'package:ia_web_front/domain/entities/article_entity_dto.dart';
import 'package:ia_web_front/views/article_editor_finish/controllers/widgets_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

CodeBlock _convertCodeDtoToBlock(CodeDto dto) {
  return CodeBlock(
    id: const Uuid().v4(), // Generar un ID único
    code: dto.code,
  );
}

QuoteBlock _convertCitationDtoToBlock(CitationDto dto) {
  return QuoteBlock(
    id: const Uuid().v4(),
    quote: dto.citation,
  );
}

ImageBlock _convertImageDtoToBlock(ImageDto dto) {
  return ImageBlock(
      id: const Uuid().v4(),
      url: dto.url,
      height: _stringPixelToInt(dto.properties["height"]),
      width: _stringPixelToInt(dto.properties["width"]),
      text: dto.text);
}

int _stringPixelToInt(String pixeles) {
  String numericString = RegExp(r'\d+').stringMatch(pixeles) ?? '50';

  // Convertir a entero
  int result = int.parse(numericString);

  return result;
}

String _mapFontSize(String size) {
  switch (size) {
    case '24px':
      return 'H1';
    case '20px':
      return 'H2';
    case '18px':
      return 'H3';
    case '16px':
      return 'H4';
    default:
      return 'P';
  }
}

TextAlign _parseAlignment(String alignment) {
  switch (alignment.toLowerCase()) {
    case 'center':
      return TextAlign.center;
    case 'right':
      return TextAlign.right;
    case 'justify':
      return TextAlign.justify;
    default:
      return TextAlign.left;
  }
}

void mapArticleDtoToBlocks(ArticleDto article, WidgetsController controller) {
  // Mapear el H1
  final h1Block = TextBlock(
    id: const Uuid().v4(),
    text: article.h1.text,
    format: BlockFormat(
      isBold: article.h1.N,
      isItalic: article.h1.I,
      isUnderline: article.h1.U,
      align: _parseAlignment(article.h1.aligment),
      fontSize: _mapFontSize(article.h1.size),
    ),
  );
  controller.addBlock(h1Block);

  // Mapear cada BodySectionDto
  for (final section in article.body) {
    // Título de la sección
    final titleBlock = TextBlock(
        id: const Uuid().v4(),
        text: section.title.text,
        format: BlockFormat(
            isBold: section.title.N,
            isItalic: section.title.I,
            isUnderline: section.title.U,
            align: _parseAlignment(section.title.aligment),
            fontSize: _mapFontSize(section.title.size)));
    controller.addBlock(titleBlock);

    // Texto simple
    for (final textDto in section.text) {
      final textBlock = TextBlock(
          id: const Uuid().v4(),
          text: textDto.text,
          format: BlockFormat(
              isBold: textDto.N,
              isItalic: textDto.I,
              isUnderline: textDto.U,
              align: _parseAlignment(textDto.aligment),
              fontSize: _mapFontSize(textDto.size)));
      controller.addBlock(textBlock);
    }

    // Tablas
    for (final tableDto in section.tables) {
      final tableBlock = TableBlock(
        id: const Uuid().v4(),
        rows: tableDto.rows
            .map((row) => row.map((cell) => cell.text).toList())
            .toList(),
      );
      controller.addBlock(tableBlock);
    }

    // Códigos
    for (final codeDto in section.codes) {
      final codeBlock = _convertCodeDtoToBlock(codeDto);
      controller.addBlock(codeBlock);
    }

    // Citas
    for (final citationDto in section.citations) {
      final quoteBlock = _convertCitationDtoToBlock(citationDto);
      controller.addBlock(quoteBlock);
    }

    for (final imageDto in section.images) {
      final imageBlock = _convertImageDtoToBlock(imageDto);
      controller.addBlock(imageBlock);
    }
  }
}
