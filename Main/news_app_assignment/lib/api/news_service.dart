import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class NewsService{
  Future <List<News> > getNews(String query) async{
    List <News> newsList = [];
    String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=8a17dee278024745bc5c0cbf31db9e0a';
    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
   if (response.statusCode==200){
      final jsonResponse= jsonDecode(response.body);

      for (final news in jsonResponse['articles']){
        if(news['urlToImage']!=null && news["description"]!=null && news['author']!=null) {
          final data = News(

              webURL: news['url'],
              date: news['publishedAt'],
              title: news['title'],
              urltoImage: news["urlToImage"],
              description: news["description"],
              content: news["content"],
              author: news['author']);
              
          newsList.add(data);
        }
      }
      
      return newsList;
    }
    else{
      throw Exception('Failed to load news');
    }
  }
}


