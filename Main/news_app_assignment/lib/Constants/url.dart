

class UrltoAPI  {
  UrltoAPI({
   required this.query,
   required this.pageNum,
   required this.limit,
  });
 final String query;
 final int pageNum;
 final int limit;
  //url to retrieve news
late Uri uriUrl= Uri(
  scheme:'https' ,
  host: 'newsapi.org', 
  path:'/v2/everything/' ,
  queryParameters: {
    'q': query, 
    'apiKey': 'c2afd48683024908b45654a9bc18d79f',
    'pageSize': '$limit',
    'page': '$pageNum',},
    
   );



}