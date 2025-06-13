import 'package:ia_web_front/features/content_list/data/models/website_model.dart';
import 'package:ia_web_front/features/content_list/domain/repository/content_list_repo.dart';

class ContentListImpl implements ContentListRepo {
  @override
  Future<Map<String, dynamic>> websiteInspection(
      String sessionId, String userId, Website website) async {
    return {
      "inspectedWebsite": {
        "root": {
          "status": "Active",
          "url": "https://technews.com",
          "name": "Tech News",
          "lastChecked": "2025-06-05T14:30:00Z",
          "contentCards": [
            {
              "title": "Future of AI",
              "url": "https://technews.com/future-of-ai",
              "keyWordsScore": 92,
              "status": "NoDone",
              "topics": [
                {
                  "keyWord": "Artificial Intelligence",
                  "kd": "45",
                  "categories": "Technology",
                  "tags": "machine learning, neural networks",
                  "date": "2025-06-01",
                  "score": "9.8",
                  "words": "1200",
                  "schemas": "HowTo, Article",
                  "status": "Covered",
                  "position": 3,
                  "volume": 250
                },
                {
                  "keyWord": "Quantum Computing",
                  "date": "2025-05-28",
                  "score": "8.5",
                  "status": "Draft",
                  "position": 5,
                  "volume": 180
                }
              ]
            }
          ]
        },
        "rankTop10Keywords": 45,
        "top10PositionScaled": 3,
        "rankTop3Keywords": 12,
        "top3PositionScaled": -2,
        "rankTop100Keywords": 128,
        "top100PositionScaled": 15
      }
    };
  }

  @override
  Future<Map<String, dynamic>> loadWebsites(
      String sessionId, String userId) async {
    return {
      "websites": [
        {
          "status": "Active",
          "url": "https://technews.com",
          "name": "Tech News",
          "lastChecked": "2025-06-05T14:30:00Z",
          "contentCards": [
            {
              "title": "Future of AI",
              "url": "https://technews.com/future-of-ai",
              "keyWordsScore": 92,
              "status": "NoDone",
              "topics": [
                {
                  "keyWord": "Artificial Intelligence",
                  "kd": "45",
                  "categories": "Technology",
                  "tags": "machine learning, neural networks",
                  "date": "2025-06-01",
                  "score": "9.8",
                  "words": "1200",
                  "schemas": "HowTo, Article",
                  "status": "Covered",
                  "position": 3,
                  "volume": 250
                },
                {
                  "keyWord": "Quantum Computing",
                  "date": "2025-05-28",
                  "score": "8.5",
                  "status": "Draft",
                  "position": 5,
                  "volume": 180
                }
              ]
            }
          ]
        },
        {
          "status": "Inactive",
          "url": "https://travelblog.org",
          "name": "World Travelers",
          "lastChecked": "2025-05-20T10:15:00Z",
          "contentCards": [
            {
              "title": "Hidden Beaches",
              "keyWordsScore": 78,
              "status": "NoDone",
              "topics": [
                {
                  "keyWord": "Eco Tourism",
                  "categories": "Sustainability",
                  "date": "2025-05-15",
                  "score": "7.2",
                  "words": "950",
                  "status": "Initiated",
                  "position": 10,
                  "volume": 95
                }
              ]
            },
            {
              "title": "Mountain Adventures",
              "keyWordsScore": 65,
              "status": "NoDone",
              "topics": []
            }
          ]
        }
      ]
    };
  }

  @override
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<Website> websites) async {
    print(websites.map((e) => e.contentCards).toList());
  }

  @override
  Future<Map<String, dynamic>> competitorAnalysis(
      String sessionId, String userId, Website website) async {
    return {
      "competitor": {
        "keywords": [
          {
            "keyword": ["Quantum Computing", "Qubit Optimization"],
            "volume": 1200,
            "kd": 65,
            "typeSearchIntent": "I"
          },
          {
            "keyword": ["Quantum Encryption"],
            "volume": 800,
            "kd": 58,
            "typeSearchIntent": "C"
          }
        ]
      }
    };
  }
}
