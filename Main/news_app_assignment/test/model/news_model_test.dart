

import 'package:flutter_test/flutter_test.dart'; // Adjust the import as needed
import 'package:news_app_assignment/model/news_model.dart';


void main() {
  group('News class tests', () {
    late News news;

    setUp(() {
      // Set up a sample News instance for testing
      news = News(
        date: '2023-08-17',
        title: 'Sample Title',
        urltoImage: 'https://example.com/image.jpg',
        description: 'Sample description',
        content: 'Sample content',
        author: 'John Doe',
        webURL: 'https://example.com/article',
      );
    });

    test('News instance should be created correctly', () {
      expect(news.date, '2023-08-17');
      expect(news.title, 'Sample Title');
      expect(news.urltoImage, 'https://example.com/image.jpg');
      expect(news.description, 'Sample description');
      expect(news.content, 'Sample content');
      expect(news.author, 'John Doe');
      expect(news.webURL, 'https://example.com/article');
    });

    // test('fromJson constructor should work correctly', () {
    //   final news = {
    //     'date': '2023-08-17',
    //     'title': 'Sample Title',
    //     'urlToImage': 'https://example.com/image.jpg',
    //     'description': 'Sample description',
    //     'content': 'Sample content',
    //     'author': 'John Doe',
    //     'webURL': 'https://example.com/article',
    //   };

    //   final convertedNews = News.fromJson(news);

    //   expect(convertedNews, equals(news) );
    // });

    test('toString method should return a formatted string', () {
      const expectedString = 'News{date: 2023-08-17, title: Sample Title, urltoImage: https://example.com/image.jpg, description: Sample description, content: Sample content, author: John Doe, webURL: https://example.com/article}';

      expect(news.toString(), equals(expectedString));
    });

    test('Equality and hashCode should work correctly', () {
      final sameNews = News(
        date: '2023-08-17',
        title: 'Sample Title',
        urltoImage: 'https://example.com/image.jpg',
        description: 'Sample description',
        content: 'Sample content',
        author: 'John Doe',
        webURL: 'https://example.com/article',
      );

      final differentNews = News(
        date: '2023-08-18',
        title: 'Different Title',
        urltoImage: 'https://example.com/different-image.jpg',
        description: 'Different description',
        content: 'Different content',
        author: 'Jane Doe',
        webURL: 'https://example.com/different-article',
      );

      expect(news, equals(sameNews));
      expect(news, isNot(equals(differentNews)));

      expect(news.hashCode, equals(sameNews.hashCode));
      expect(news.hashCode, isNot(equals(differentNews.hashCode)));
    });
  });
}
