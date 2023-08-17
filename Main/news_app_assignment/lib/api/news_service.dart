import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/src/mock_client.dart';

import '../model/news_model.dart';

class NewsService{
  set client(MockClient client) {}

  //retrieve news from api
  Future <List<News> > getNews(String query) async{
    List <News> newsList = [];//list of news
    String url = 'https://newsapi.org/v2/everything?q=$query&apiKey=682e3e6915184e3384c4df0f4e6f92d4';//url to retrieve news
    final response = await http.get(Uri.parse(url));//get the response from the url
    
   if (response.statusCode==200){
    //if the server returns a 200 OK response
      final jsonResponse= jsonDecode(response.body);
      //loop through the list of news
      for (final news in jsonResponse['articles']){
        //check if the news has all the required fields
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
      //throw an exception if the server did not return a 200 OK response
      throw Exception('Failed to load news');
    }
  }
}


