import 'package:ia_web_front/data/models/website_model.dart';
import 'package:ia_web_front/domain/repository/content_list_repo.dart';

class ContentListImpl implements ContentListRepo {
  @override
  Future<Map<String, dynamic>> websiteInspection(
      String sessionId, String userId, Website website) async {
    return {
      'website': {},
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
              "volume": 250,
              "keyWordsScore": 92,
              "topics": [
                {
                  "keyWord": "Artificial Intelligence",
                  "kd": "AI-2025",
                  "categories": "Technology",
                  "tags": "machine learning,neural networks",
                  "date": "2025-06-01",
                  "score": "9.8",
                  "words": "1200",
                  "schemas": "HowTo,Article",
                  "status": "Covered"
                },
                {
                  "keyWord": "Quantum Computing",
                  "date": "2025-05-28",
                  "score": "8.5",
                  "status": "Draft"
                }
              ]
            }
          ]
        },
        {
          "status": "Inactive",
          "url": "https://travelblog.org",
          "name": "World Travelers",
          "lastChecked": '2025-05-20T10:15:00Z',
          "contentCards": [
            {
              "title": "Hidden Beaches",
              "volume": 180,
              "keyWordsScore": 78,
              "topics": [
                {
                  "keyWord": "Eco Tourism",
                  "categories": "Sustainability",
                  "date": "2025-05-15",
                  "score": "7.2",
                  "words": "950",
                  "status": "Initiated"
                }
              ]
            },
            {
              "title": "Mountain Adventures",
              "volume": 95,
              "keyWordsScore": 65,
              "topics": []
            }
          ]
        }
      ]
    };
  }

  @override
  Future<void> saveWebsitesData(
      String sessionId, String userId, List<Website> websites) async {}

  @override
  Future<Map<String, dynamic>> competitorAnalysis(
      String sessionId, String userId, Website website) async {
    return {'competitor': {}};
  }
}
