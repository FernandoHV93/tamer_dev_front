class ArticleGeneratorGeneral {
  String language;
  String articleType;
  String articleMainKeyword;
  String articleTitle;
  String articleMetaTitle = "";

  ArticleGeneratorGeneral({
    required this.language,
    required this.articleType,
    required this.articleMainKeyword,
    required this.articleTitle,
  });

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'articleType': articleType,
      'articleMainKeyword': articleMainKeyword,
      'articleTitle': articleTitle,
      'articleMetaTitle': articleMetaTitle,
    };
  }
}

class ArticleGeneratorSettings {
  String articleSize;
  String targetCountry;
  String aiModel;
  String humanizeText;
  String pointOfView;
  String toneOfVoice;
  String detailsToInclude = "";
  Map<String, String> brandVoice = {
    'brandVoice': 'Brand Voice',
    'brandVoiceDescription': 'Brand Voice Description',
  };

  ArticleGeneratorSettings({
    required this.articleSize,
    required this.targetCountry,
    required this.aiModel,
    required this.humanizeText,
    required this.pointOfView,
    required this.toneOfVoice,
  });

  Map<String, dynamic> toJson() {
    return {
      'articleSize': articleSize,
      'targetCountry': targetCountry,
      'aiModel': aiModel,
      'humanizeText': humanizeText,
      'pointOfView': pointOfView,
      'toneOfVoice': toneOfVoice,
      'detailsToInclude': detailsToInclude,
      'brandVoice': brandVoice,
    };
  }
}

class ArticleMediaHub {
  bool aiImages;
  int numberOfImages;
  String imageStyle;
  String imageSize;
  bool youtubeVideos;
  int numberOfVideos;
  String layoutOption;
  bool includeKeywords;
  bool placeUnderHeadings;
  String additionalInstructions;
  String brandName;

  ArticleMediaHub({
    required this.aiImages,
    required this.numberOfImages,
    required this.imageStyle,
    required this.imageSize,
    required this.youtubeVideos,
    required this.numberOfVideos,
    required this.layoutOption,
    required this.additionalInstructions,
    required this.brandName,
    required this.includeKeywords,
    required this.placeUnderHeadings,
  });

  Map<String, dynamic> toJson() {
    return {
      'aiImages': aiImages,
      'numberOfImages': numberOfImages,
      'imageStyle': imageStyle,
      'imageSize': imageSize,
      'youtubeVideos': youtubeVideos,
      'numberOfVideos': numberOfVideos,
      'layoutOption': layoutOption,
      'includeKeywords': includeKeywords,
      'strictMediaPlacement': placeUnderHeadings,
      'additionalInstructions': additionalInstructions,
      'brandName': brandName,
    };
  }
}

class ArticleSEO {
  List<String> keywords;

  ArticleSEO({
    required this.keywords,
  });

  Map<String, dynamic> toJson() {
    return {
      'keywords': keywords,
    };
  }
}

class ArticleStructure {
  String typeOfHook;
  String introductoryHookBrief;
  Map<String, bool?> contentOptions = {
    'conclusion': false,
    'tables': false,
    'heading3': false,
    'lists': false,
    'italics': false,
    'quotes': false,
    'keyTakeaways': false,
    'faqs': false,
    'bold': false,
    'stats': false,
    'realPeopleOpinion': false
  };

  ArticleStructure({
    required this.typeOfHook,
    required this.introductoryHookBrief,
    required this.contentOptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'typeOfHook': typeOfHook,
      'introductoryHookBrief': [introductoryHookBrief],
      'conclusion': contentOptions['conclusion'],
      'tables': contentOptions['tables'],
      'heading3': contentOptions['heading3'],
      'lists': contentOptions['lists'],
      'italics': contentOptions['italics'],
      'quotes': contentOptions['quotes'],
      'keyTakeaways': contentOptions['keyTakeaways'],
      'faqs': contentOptions['faqs'],
      'bold': contentOptions['bold'],
      'stats': contentOptions['stats'],
      'realPeopleOpinion': contentOptions['realPeopleOpinion'],
    };
  }
}

class ArticleDistributionsEntity {
  bool sourceLinks;
  bool citations;
  List<String> internalLinking;
  List<String> externalLinking;
  Map<String, bool?> articleSydication;

  ArticleDistributionsEntity({
    required this.sourceLinks,
    required this.citations,
    required this.internalLinking,
    required this.externalLinking,
    required this.articleSydication,
  });
  Map<String, dynamic> toJson() {
    return {
      'sourceLinks': sourceLinks,
      'citations': citations,
      'internalLinking': internalLinking,
      'externalLinking': externalLinking,
      'articleSydication': articleSydication,
    };
  }
}

class ArticleBuilderEntity {
  String sessionId;
  String userId;
  ArticleGeneratorGeneral articleGeneratorGeneral;
  ArticleGeneratorSettings articleSettings;
  ArticleMediaHub articleMediaHub;
  ArticleSEO articleSEO;
  ArticleStructure articleStructure;
  ArticleDistributionsEntity articleDistribution;

  ArticleBuilderEntity({
    required this.sessionId,
    required this.userId,
    required this.articleGeneratorGeneral,
    required this.articleSettings,
    required this.articleMediaHub,
    required this.articleSEO,
    required this.articleStructure,
    required this.articleDistribution,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionID': sessionId,
      'userID': userId,
      'articleGeneratorGeneral': articleGeneratorGeneral.toJson(),
      'articleGeneratorSettings': articleSettings.toJson(),
      'articleMediaHub': articleMediaHub.toJson(),
      'articleSEO': articleSEO.toJson(),
      'articleStructure': articleStructure.toJson(),
      'articleConnectToWeb': {
        "sourceLinks": articleDistribution.sourceLinks,
        'citationsLinks': articleDistribution.citations,
        'internalLinks': articleDistribution.internalLinking,
        'externalLinks': articleDistribution.externalLinking
      },
      'articleSyndication': articleDistribution.articleSydication,
    };
  }
}
