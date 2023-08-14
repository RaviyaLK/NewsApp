import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../api/news_service.dart';
import '../model/news_model.dart';
import '../widgets/colors.dart';
import '../widgets/news_card.dart';
import 'infopage.dart';
String searchQuery = '';
final newsRepositoryProvider= Provider((ref) => NewsService());
final asyncNewsProvider = AsyncNotifierProvider<AsyncNewsNotifier,List<News>> (()=> AsyncNewsNotifier());
final selectedNews = StateProvider((ref) => News(
  date: '',
  title: '',
  webURL: '',
  description: '',
  content: '', 
  author: '',
  urltoImage:'', 
));
class AsyncNewsNotifier extends AsyncNotifier<List<News>> {
  @override
  FutureOr<List<News>> build() {
    return getNews(searchQuery);
  }
  Future <List<News>> getNews(searchQuery) async{
    state= const AsyncLoading();
    List<News> list=[];
    state=await AsyncValue.guard(() async {
      list= await ref.read(newsRepositoryProvider).getNews(searchQuery);
      return list;
    });
    return list;
  }

  }




final searchBarFocusedProvider = StateProvider<bool>((ref) => false);
final FocusNode _searchFocusNode = FocusNode();

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchBarFocused = ref.watch(searchBarFocusedProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: hexStringToColor("#1858d2"),
        centerTitle: true,
        title: const Text('News Feed'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 20),
            child: Row(
              children: [
                Expanded(
                   child:Container(
                 
                    width: isSearchBarFocused ? screenWidth * 0.65 : screenWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _searchFocusNode,
                            onTap: () {
                              _searchFocusNode.requestFocus();
                              ref.read(searchBarFocusedProvider.notifier).state = true;
                            },
                            onChanged: (value) {
                             ref.read(asyncNewsProvider.notifier).getNews(value);
                              // Handle onChanged
                            },
                            decoration: const InputDecoration.collapsed(
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isSearchBarFocused)
                  GestureDetector(
                    onTap: () {
                      ref.read(searchBarFocusedProvider.notifier).state = false;
                      _searchFocusNode.unfocus();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer(
      
          builder: (context, ref, child) {
            final newsList = ref.watch (asyncNewsProvider);
            return newsList.when(data: (news){
              return ListView.separated(
                separatorBuilder:(context, index) => const SizedBox(
                   height: 10,
                   ) ,
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),

                itemCount: news.length < 10 ? news.length : 10,
                itemBuilder: (context, index) {
                  return  NewsCard(
                      title: news[index].title,
                      description: news[index].description,
                      image: news[index].urltoImage,
                      date: news[index].date,
                      onpress: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InfoPage(
                        date: news[index].date,
                        title: news[index].title,
                        webURL: news[index].webURL,
                        description: news[index].description,
                        content: news[index].content,
                        author: news[index].author,
                        image: news[index].urltoImage,)));
                        
                      },
                    );
                  
                },
              );
            }, error: (e,_){
              return Column(children: [Text(_.toString())],);

            }, loading: ()=> const Padding(
              padding: EdgeInsets.all(100.0),
              child: Center(child: CircularProgressIndicator(color: Colors.blue, )),
            ),);
          },
        
        ), 
      ),
    );
  }
}
