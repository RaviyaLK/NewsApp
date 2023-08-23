class UrltoAPI  {
  UrltoAPI({
   required this.query,
   required this.pageNum,
  });
 final String query;
 final int pageNum;
late Uri uriUrl= Uri(
  scheme:'https' ,
  host: 'newsapi.org', 
  path:'/v2/everything/' ,
  queryParameters: {
    'q': query, 
    'apiKey': '8a17dee278024745bc5c0cbf31db9e0a',
    'pageSize': '10',
    'page': '$pageNum'
    },
    
   );



}