

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
    'apiKey': 'fca8c166d0894666b19379a95ba7638c',
    'pageSize': '$limit',
    'page': '$pageNum',},
    
   );



}