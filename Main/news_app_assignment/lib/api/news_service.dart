import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class NewsService{
  Future <List<News> > getNews(String query) async{
    List <News> newsList = [];
    String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=682e3e6915184e3384c4df0f4e6f92d4';
    final response = await http.get(Uri.parse(url));
    
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


