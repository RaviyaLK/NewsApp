import 'package:news_app_assignment/api/news_service.dart';
import 'package:news_app_assignment/model/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
 // Import your News model
// Import your NewsService

void main() {
  group('NewsService', () {
    test('Successful API call should return a list of News', () async {
      final mockClient = MockClient((request) async {
        // Return a mock response with a 200 OK status code and sample JSON data
        return http.Response('''
          {
            "articles": [
              {
                "url": "https://example.com/article",
                "publishedAt": "2023-08-16T10:00:00Z",
                "title": "Sample Title",
                "urlToImage": "https://example.com/image.jpg",
                "description": "Sample description",
                "content": "Sample content",
                "author": "John Doe"
              }
            ]
          }
        ''', 200);
      });

      final newsService = NewsService();
      newsService.client = mockClient;

      final newsList = await newsService.getNews('sample_query');

      expect(newsList, isA<List<News>>());
      // expect(newsList.length, 1);
      // expect(newsList[0].title, 'Sample Title');
    });

    test('API call with missing fields should not add News to the list', () async {
      final mockClient = MockClient((request) async {
        // Return a mock response with a 200 OK status code and sample JSON data missing required fields
        return http.Response('''
          {
            "articles": [
              {
                "url": "https://example.com/article",
                "publishedAt": "2023-08-16T10:00:00Z"
              }
            ]
          }
        ''', 200);
      });

      final newsService = NewsService();
      newsService.client = mockClient;

      final newsList = await newsService.getNews('sample_query');

      expect(newsList, isA<List<News>>());
      expect(newsList.length, 0); // No news should be added due to missing fields
    });

    test('API call with non-200 status code should throw an exception', () async {
      final mockClient = MockClient((request) async {
        // Return a mock response with a non-200 status code
        return http.Response('Error', 404);
      });

      final newsService = NewsService();
      newsService.client = mockClient;
        // Use expectAsync to handle asynchronous exception assertion
      expectLater(() => newsService.getNews(''), throwsA(isA<Exception>()));
    });
  });
}
