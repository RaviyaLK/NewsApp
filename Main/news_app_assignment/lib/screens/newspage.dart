import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_assignment/widgets/removespaces.dart';
import 'package:news_app_assignment/widgets/savelocally.dart';
import 'package:news_app_assignment/widgets/searchbar.dart';
import 'dart:async';
import '../api/news_service.dart';
import '../model/news_model.dart';
import '../widgets/colors.dart';
import '../widgets/news_card.dart';
import 'infopage.dart';

String searchQuery = '';//search query to pass to the news api
TextEditingController searchController = TextEditingController(); //controller for the search bar
List<String> searchHistory = []; //list of search history
final newsRepositoryProvider = Provider((ref) => NewsService()); //provider for the news api
final asyncNewsProvider =AsyncNotifierProvider<AsyncNewsNotifier, List<News>>( () => AsyncNewsNotifier());//provider for the news list
final searchHistoryProvider = StateProvider((ref) => searchHistory);//provider for the search history
final searchBarFocusedProvider = StateProvider<bool>((ref) => false);//provider for the search bar focus
final FocusNode searchFocusNode = FocusNode();
final save = Savelocally();
final removespaces= Removespaces();
final scrollController = ScrollController();
int pageNum = 1;
 //page number for the news api

class AsyncNewsNotifier extends AsyncNotifier<List<News>> {
  @override

  FutureOr<List<News>> build() {                 
    return getNews(searchQuery); 
  }

  Future<List<News>> getNews(searchQuery) async {
    state = const AsyncLoading(); //sets the state to loading
    List<News> list = [];
    
    //gets the news list from the api using the search query
    
    state = await AsyncValue.guard(() async { //sets the state to success
      list = await ref.read(newsRepositoryProvider).getNews(searchQuery,pageNum);//gets the news list from the api
      return list;//returns the news list
    });
    return list;
  }
}
 

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});
  
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Debouncer debouncer = Debouncer();//
    final isSearchBarFocused = ref.watch(searchBarFocusedProvider); //checks if the search bar is focused
    final screenWidth = MediaQuery.of(context).size.width; //gets the screen width
    final screenHeight = MediaQuery.of(context).size.height; //gets the screen height

    return Scaffold(
      backgroundColor: hexStringToColor("##f4f6f8"),
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        backgroundColor: hexStringToColor("#1858d2"),
        centerTitle: true,
        title: const Text('News Feed'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 20),
            child:
             Row(
              children: [
                Expanded(
                  child: Container(
                    width: isSearchBarFocused ? screenWidth * 0.65 : screenWidth * 0.8, //sets the width of the search bar according to the focus
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey[300],
                    ),
                    child:CustomSearchBar(
                      onTap: ()async {
                      searchFocusNode.requestFocus();                    
                      ref.read(searchBarFocusedProvider.notifier).state = true;
                      searchHistory = await save.readData('searchHistory') ;
                      ref.read(searchHistoryProvider.notifier).state = searchHistory;
                    },
                     onChanged:(value){
                      if (value.isNotEmpty&&searchController.text.trim().isNotEmpty) {
                        debouncer.run(() {
                         ref.read(asyncNewsProvider.notifier).getNews(value); //gets the news list from the api using the search query
                         });
                        }
                      if (value.isEmpty) {
                        ref.read(asyncNewsProvider.notifier).getNews('Random'); //gets the news list from the api using the search query
                        }
                     }, 
                     onEditingComplete:(){
                      if(searchController.text.trim().isNotEmpty){
                        removespaces.removeExtraSpaces(searchController);
                        if (searchHistory.length > 5 &&
                           searchController.text.trim().isNotEmpty &&
                           !searchHistory.contains(searchController.text)) {//checks if the search history is greater than 5 and if the search query is not empty and if the search query is not already in the search history 
                          searchHistory.removeAt(0);
                          searchHistory.add(searchController.text.trim());
                          save.writeData(searchHistory,'searchHistory'); //sets the search history to the shared preferences
                         
                        } else if (searchController.text.isNotEmpty && 
                            !searchHistory.contains(searchController.text)) {
                          searchHistory.add(searchController.text);
                          save.writeData(searchHistory,'searchHistory');
                          
                        } } 
                     },
                      isSearchBarFocused: isSearchBarFocused, 
                      searchFocusNode: searchFocusNode, 
                      searchController: searchController,) 
                   
                  ),
                ),
                if (isSearchBarFocused)
                  GestureDetector(
                    onTap: () {
                      ref.read(searchBarFocusedProvider.notifier).state = false; //sets the search bar focus to false
                      searchFocusNode.unfocus();
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
            final newsList = ref.watch(asyncNewsProvider);
            if (isSearchBarFocused && searchController.text.isEmpty) {
              return ListView.separated(
                reverse: true,
                separatorBuilder: (context, index) => const Padding(
                  padding:  EdgeInsets.only(
                    left: 14.0, 
                    right: 14.0),
                  child:  Divider(
                    height: 1,
                    thickness: 1,
                    )),
                shrinkWrap: true,
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    hoverColor: Colors.grey[300],                      
                    tileColor: Colors.white,
                    leading: const Icon(Icons.history),
                    selectedTileColor: Colors.grey[300],
                    horizontalTitleGap: 4,
                    onTap: () {
                      searchController.text = searchHistory[index]; //sets the search query to the search bar
                      ref.read(asyncNewsProvider.notifier).getNews(searchHistory[index]); //gets the news list from the api using the search query
                      ref.read(searchBarFocusedProvider.notifier).state = false; //sets the search bar focus to false
                      searchFocusNode.unfocus();
                    },
                    title: Text(searchHistory[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              );
            } else {
              return newsList.when(
                data: (news) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: news.length < 10 ? news.length : 10,
                      itemBuilder: (context, index) {
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: 1,
                          child: NewsCard(
                            title: news[index].title,
                            description: news[index].description,
                            image: news[index].urltoImage,
                            date: news[index].date.substring(0, 10),
                            onpress: () {
                              Navigator.push(
                                context,
                                _createRoute( //creates a route to the news details page
                                  news[index].urltoImage,
                                  news[index].content,
                                  news[index].description,
                                  news[index].title,
                                  news[index].date.substring(0, 10),
                                  news[index].author,
                                  news[index].webURL,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (e, _) {
                  return Column(
                    children: [
                     
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        child: Center(
                          child: Image(
                            height: screenHeight * 0.5,
                            width: screenWidth * 0.7,
                            image: const NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/755/755014.png",
                            ),
                          ),
                        ),
                      ),
                       Text("Error: $e",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                       
                    ], 
                  );
                },
                loading: () => Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.blue,
                      size: 100,
                    ),
                  ),
                ),
              );
            }
          }),
      ),
    );
  }
}

class Debouncer {//debounces the search bar
  final int milliseconds;
  Timer? timer;

  Debouncer({this.milliseconds = 1000});

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action); //waits for 1 second before executing the action
  }
}

Route _createRoute(
  String image,
  String content,
  String description,
  String title,
  String date,
  String author,
  String webURL,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoPage(
      title: title,
      content: content,
      description: description,
      author: author,
      date: date,
      webURL: webURL,
      image: image,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) { //creates a transition animation
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.elasticInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
