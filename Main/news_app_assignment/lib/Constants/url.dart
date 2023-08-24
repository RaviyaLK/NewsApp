

class UrltoAPI  {
  UrltoAPI({
   required this.query,
   required this.pageNum,
  });
 final String query;
 final int pageNum;
  //url to retrieve news
late Uri uriUrl= Uri(
  scheme:'https' ,
  host: 'newsapi.org', 
  path:'/v2/everything/' ,
  queryParameters: {
    'q': query, 
    'apiKey': 'a2a13804f1b846e5931bff67d979354e',
    'pageSize': '10',
    'page': '$pageNum',},
    
   );



}