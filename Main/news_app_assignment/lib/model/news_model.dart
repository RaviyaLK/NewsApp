class News{

  String date;
  String title;
  String urltoImage;
  String description;
  String content;
  String author;
  String webURL;

  News({
    required this.date,
    required this.title,
    required this.urltoImage,
    required this.description,
    required this.content,
    required this.author,
    required this.webURL,

  });

  factory News.fromJson(Map<String, dynamic> news){
    return News(
        webURL: news['url'],
        date: news['publishedAt'],
        title: news['title'],
        urltoImage: news['urlToImage'],
        description: news['"description'],
        content:news['content'],
        author: news['author'],
      
    );
  }
}