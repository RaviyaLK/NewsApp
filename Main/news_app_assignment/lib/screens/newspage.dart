import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../api/news_service.dart';
import '../model/news_model.dart';
import '../widgets/colors.dart';
import '../widgets/news_card.dart';
import 'infopage.dart';
String searchQuery = '';
TextEditingController searchController = TextEditingController();

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
    final screenHeight= MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: hexStringToColor("##f4f6f8"),
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
                            controller: searchController,
                            
                            focusNode: _searchFocusNode,
                            onTap: () {
                              _searchFocusNode.requestFocus();
                              ref.read(searchBarFocusedProvider.notifier).state = true;
                            },
                            onChanged: (value) {
                              
                             
                            if(searchController.text.length>0){
                            //  searchQuery=value;
                              ref.read(asyncNewsProvider.notifier).getNews(value);
                             }
                             else{
                              
                             } // Handle onChanged
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
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: ListView.separated(
                  separatorBuilder:(context, index) => const SizedBox(
                     height: 20,
                     ) ,
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
              
                  itemCount: news.length < 10 ? news.length : 10,
                  itemBuilder: (context, index) {
                    return  NewsCard(
                        title: news[index].title,
                        description: news[index].description,
                        image: news[index].urltoImage,
                        date: news[index].date.substring(0,10),
                        onpress: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InfoPage(
                          date: news[index].date.substring(0,10),
                          title: news[index].title,
                          webURL: news[index].webURL,
                          description: news[index].description,
                          content: news[index].content,
                          author: news[index].author,
                          image: news[index].urltoImage,)));
                          
                        },
                      );
                    
                  },
                ),
              );
            }, error: (e,_){
              return  Column(
                children: [
                  
                  
                   Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    child: Center(child:Image(
                      height: screenHeight*0.7,
                      
                      image: const NetworkImage("https://img.freepik.com/free-vector/oops-404-error-with-broken-robot-concept-illustration_114360-1920.jpg?w=740&t=st=1691997309~exp=1691997909~hmac=c92c2955131bfc8a2de4d510ca007386128b20d195063f7f74c9d1214022e160",)) ),
                  ),
                    
                ],);

            }, loading: ()=> Padding(
              padding: const EdgeInsets.fromLTRB(20,100,20,20),
              child: Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.blue, size: 100)),
            ),);
          //   const Padding(
          //     padding: EdgeInsets.all(100.0),
          //     child: Center(
          //       child: LoadingAnimationWidget.beat(color: Colors.blue, size: 12),
          //       ),
          //   ),);
          // },
        
          }), 
      ),
    );
    
  }
  
}
