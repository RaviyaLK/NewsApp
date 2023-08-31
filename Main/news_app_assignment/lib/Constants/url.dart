

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
    'apiKey': 'a2a13804f1b846e5931bff67d979354e',
    'pageSize': '$limit',
    'page': '$pageNum',},
    
   );



}