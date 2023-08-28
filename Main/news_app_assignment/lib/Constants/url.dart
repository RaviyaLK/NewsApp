

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
    'apiKey': 'fca8c021d0892938b19379a87ae7638c ',
    'pageSize': '$limit',
    'page': '$pageNum',},
    
   );



}