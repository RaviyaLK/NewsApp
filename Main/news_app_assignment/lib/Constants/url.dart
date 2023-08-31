

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
    'apiKey': '682e3e6915184e3384c4df0f4e6f92d4',
    'pageSize': '$limit',
    'page': '$pageNum',},
    
   );



}