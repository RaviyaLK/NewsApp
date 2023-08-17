class News{
  
  //news model created for the news api
  final String date;
  final String title;
  final String urltoImage;
  final String description;
  final String content;
  final String author;
  final String webURL;

  News({
    //constructor for the news model
   required this.date,
    required this.title,
    required this.urltoImage,
    required this.description,
    required this.content,
    required this.author,
    required this.webURL,

  });


  factory News.fromJson(Map<String, dynamic> news){
    //factory method to convert json to news model
    return News(
        webURL: news['url'] ?? "",
        date: news['publishedAt']?? "",
        title: news['title']?? "",
        urltoImage: news['urlToImage']?? "",
        description: news['description']?? "",
        content:news['content']?? "",
        author: news['author']?? "",
      
    );
  }
  @override
  String toString() {
    //tostring method for the news model
    return 'News{date: $date, title: $title, urltoImage: $urltoImage, description: $description, content: $content, author: $author, webURL: $webURL}';
  }

  @override
  //overriding the == operator for the news model
  bool operator ==(Object other) { 
    //if the objects are identical return true
    if (identical(this, other)) return true;

    return other is News &&
        other.date == date &&
        other.title == title &&
        other.urltoImage == urltoImage &&
        other.description == description &&
        other.content == content &&
        other.author == author &&
        other.webURL == webURL;
  }

  @override
  //overriding the hashcode for the news model
  int get hashCode {
    return date.hashCode ^
        title.hashCode ^
        urltoImage.hashCode ^
        description.hashCode ^
        content.hashCode ^
        author.hashCode ^
        webURL.hashCode;
  }
}