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
  String aiWordsRemoval;
  String detailsToInclude = "";
  Map<String, dynamic> brandVoice = {
    'id': '',
    'brandName': 'Brand Voice',
    'toneOfVoice': '',
    'keyValues': <String>[],
    'targetAudience': '',
    'brandIdentityInsights': '',
  };

  ArticleGeneratorSettings({
    required this.articleSize,
    required this.targetCountry,
    required this.aiModel,
    required this.humanizeText,
    required this.pointOfView,
    required this.toneOfVoice,
    this.aiWordsRemoval = 'No AI Words Removal',
  });

  Map<String, dynamic> toJson() {
    return {
      'articleSize': articleSize,
      'targetCountry': targetCountry,
      'aiModel': aiModel,
      'humanizeText': humanizeText,
      'pointOfView': pointOfView,
      'toneOfVoice': toneOfVoice,
      'aiWordsRemoval': aiWordsRemoval,
      'detailsToInclude': detailsToInclude,
      'brandVoice': brandVoice,
    };
  }
}

class ArticleMediaHub {
  bool aiImages;
  int numberOfImages;
  String imageStyle;
  Map<String, int> imageSize;
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
      'layoutOptions': layoutOption,
      'includeKeywords': includeKeywords,
      'placeUnderHeadings': placeUnderHeadings,
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
    'Conclusion': false,
    'Tables': false,
    'Heading3': false,
    'Lists': false,
    'Italics': false,
    'Quotes': false,
    'KeyTakeaways': false,
    'FAQS': false,
    'Bold': false,
    'Stats': false,
    'RealPeopleOpinion': false
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
      'conclusion': contentOptions['Conclusion'],
      'tables': contentOptions['Tables'],
      'heading3': contentOptions['Heading3'],
      'lists': contentOptions['Lists'],
      'italics': contentOptions['Italics'],
      'quotes': contentOptions['Quotes'],
      'keyTakeaways': contentOptions['KeyTakeaways'],
      'faqs': contentOptions['FAQS'],
      'bold': contentOptions['Bold'],
      'stats': contentOptions['Stats'],
      'realPeopleOpinion': contentOptions['RealPeopleOpinion'],
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
  ArticleGeneratorGeneral articleGeneratorGeneral;
  ArticleGeneratorSettings articleSettings;
  ArticleMediaHub articleMediaHub;
  ArticleSEO articleSEO;
  ArticleStructure articleStructure;
  ArticleDistributionsEntity articleDistribution;

  ArticleBuilderEntity({
    required this.articleGeneratorGeneral,
    required this.articleSettings,
    required this.articleMediaHub,
    required this.articleSEO,
    required this.articleStructure,
    required this.articleDistribution,
  });

  Map<String, dynamic> toJson() {
    return {
      'articleGeneratorGeneral': articleGeneratorGeneral.toJson(),
      'articleGeneratorSettings': articleSettings.toJson(),
      'articleMediaHub': articleMediaHub.toJson(),
      'articleSEO': articleSEO.toJson(),
      'articleStructure': articleStructure.toJson(),
      'articleConnectToWeb': {
        "sourceLinks": articleDistribution.sourceLinks,
        'citationLinks': articleDistribution.citations,
        'internalLinks': articleDistribution.internalLinking,
        'externalLinks': articleDistribution.externalLinking
      },
      'articleSyndication': articleDistribution.articleSydication,
    };
  }
}
