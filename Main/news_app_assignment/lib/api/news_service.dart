import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/src/mock_client.dart';
import 'package:news_app_assignment/Constants/url.dart';

import '../model/news_model.dart';

class NewsService{

  set client(MockClient client) {}

  //retrieve news from api
  Future <List<News> > getNews(String query,int pageNum) async{
    
    List <News> newsList = [];
     UrltoAPI urlob = UrltoAPI(query: query, pageNum: pageNum);
     Uri url = urlob.uriUrl;//list of news
  //url to retrieve news
    final response = await http.get(url);//get the response from the url
     if (response.statusCode==200){
    //if the server returns a 200 OK response
      final jsonResponse= jsonDecode(response.body);//decode the json response
      //loop through the list of news
      for (final news in jsonResponse['articles']){
        //check if the news has all the required fields
        if(news['urlToImage']!=null && news["description"]!=null && news['author']!=null) {
          final data = News(//create a news object

              webURL: news['url'],
              date: news['publishedAt'],
              title: news['title'],
              urltoImage: news["urlToImage"],
              description: news["description"],
              content: news["content"],
              author: news['author']);
              
          newsList.add(data);//add the news to the list
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


