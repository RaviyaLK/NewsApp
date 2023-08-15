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

final newsRepositoryProvider = Provider((ref) => NewsService());
final asyncNewsProvider =
    AsyncNotifierProvider<AsyncNewsNotifier, List<News>>(
        () => AsyncNewsNotifier());
final selectedNews = StateProvider((ref) => News(
      date: '',
      title: '',
      webURL: '',
      description: '',
      content: '',
      author: '',
      urltoImage: '',
    ));

class AsyncNewsNotifier extends AsyncNotifier<List<News>> {
  @override
  FutureOr<List<News>> build() {
    return getNews(searchQuery);
  }

  Future<List<News>> getNews(searchQuery) async {
    state = const AsyncLoading();
    List<News> list = [];
    state = await AsyncValue.guard(() async {
      list = await ref.read(newsRepositoryProvider).getNews(searchQuery);
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
    Debouncer _debouncer = Debouncer();
    final isSearchBarFocused = ref.watch(searchBarFocusedProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: hexStringToColor("##f4f6f8"),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: hexStringToColor("#1858d2"),
        centerTitle: true,
        title: const Text('News Feed'),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
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
                              if (value.isNotEmpty){
                                _debouncer.run(() {
                                  ref.read(asyncNewsProvider.notifier).getNews(value);
                                }
                                );
                                }else{
                                    ref.read(asyncNewsProvider.notifier).getNews('Apple');

                              }
                              // if (searchController.text.isNotEmpty) {
                              //   ref.read(asyncNewsProvider.notifier).getNews(value);
                              // } else {
                              //   ref.read(asyncNewsProvider.notifier).getNews('');
                              // }
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
            final newsList = ref.watch(asyncNewsProvider);
            return newsList.when(
              data: (news) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    shrinkWrap: true,
                    controller: ScrollController(keepScrollOffset: false),
                    itemCount: news.length < 10 
                    ? news.length 
                    : 10,
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
                            
                            Navigator.push(context,
                            _createRoute(
                              news[index].urltoImage,
                              news[index].content,
                              news[index].description,
                              news[index].title,
                              news[index].date.substring(0, 10),
                              news[index].author,
                             news[index].webURL)








                              
                              // context,
                              // MaterialPageRoute(
                              //   builder: (context) => InfoPage(
                              //     date: news[index].date.substring(0, 10),
                              //     title: news[index].title,
                              //     webURL: news[index].webURL,
                              //     description: news[index].description,
                              //     content: news[index].content,
                              //     author: news[index].author,
                              //     image: news[index].urltoImage,
                              //   ),
                              // ),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Error: $e"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: Center(
                        // child: Image.network("https://png.pngtree.com/element_pic/16/10/28/445367348af63e0be1aee16a1dd5bec8.jpg"),
                        child: Image(
                          height: screenHeight * 0.7,
                          width: screenWidth * 0.7,
                          image: const NetworkImage(
                            "https://cdn-icons-png.flaticon.com/512/755/755014.png",
                          ),
                        ),
                      ),
                    ),
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
          },
        ),
      ),
   
    );
    
  }
  
}
class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds=1000});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
  
}

Route _createRoute( 
String image,
String content,
String description,
String title,
String date,
String author,
String webURL,) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoPage(title: title,content: content,description: description,author: author,date: date,webURL: webURL,image: image),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
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

